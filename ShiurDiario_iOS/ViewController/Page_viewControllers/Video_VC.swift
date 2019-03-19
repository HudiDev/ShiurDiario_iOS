//
//  Video_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit
import AVKit
import Firebase

class Video_VC: UIViewController {
    
    var prefix: String?
    var dafName: String!
    
    private var videoPlayer: AVPlayer!
    private var videoLayer: AVPlayerLayer!
    private var db: Firestore!
    private var playPauseToggle: Bool = false
    private var videoControllersToggle: Bool = true
    var observer: Any!
    
    
    @IBOutlet weak var commentLabelSection: UIView!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var addNewCommentBtn: UIButton!
    @IBOutlet weak var controllersContainer: UIStackView!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var videoLoaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var durationContainer: UIView!
    @IBOutlet weak var passedTime: UILabel!
    @IBOutlet weak var durationTime: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
    
    
    var newCommentStr: String! {
        return commentTextView.text
    }

    
    @IBAction func videoSlider(_ sender: UISlider) {
        videoPlayer.seek(to: CMTimeMake(Int64(sender.value*1000), 1000))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        
        if prefix == nil { prefix = "Menachot_95" }
        
        videoTitle.text = dafName
        
        guard let url = URL(string: "http://shiurdiario.com/media/video/\(prefix!).mp4") else { return }
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        videoLayer.videoGravity = .resize
        videoView.layer.insertSublayer(videoLayer, at: 0)
        
        commentLabelSection.layer.borderWidth = 0.4
        commentLabelSection.layer.borderColor = UIColor.black.cgColor
        commentTextView.delegate = self
        
        self.observer = addTimeObserver()
    }
    
    private func addTimeObserver() -> Any {
        
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        
        let observer = videoPlayer.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] (time) in
            
            if self?.videoPlayer.currentItem?.status == AVPlayerItemStatus.readyToPlay {
                
                if (self?.videoPlayer.currentItem?.isPlaybackLikelyToKeepUp) != nil {
                    self?.videoLoaderIndicator.stopAnimating()
                } else {
                    self?.videoLoaderIndicator.startAnimating()
                }
                
                guard let currentItem = self?.videoPlayer.currentItem else { return }
                self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
                self?.timeSlider.minimumValue = 0
                self?.timeSlider.value = Float(currentItem.currentTime().seconds)
                self?.passedTime.text = self?.getTimeString(from: currentItem.currentTime())
            } else {
                self?.videoLoaderIndicator.startAnimating()
            }
        })
        return observer
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoLayer.frame = videoView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer.play()
        setupAVPlayerObservers(self.videoPlayer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoPlayer.pause()
        self.observer = nil
        self.videoPlayer.removeObserver(self, forKeyPath: "status")
        if #available(iOS 10.0, *) {
            self.videoPlayer.removeObserver(self, forKeyPath: "timeControlStatus")
        } else {
            self.videoPlayer.removeObserver(self, forKeyPath: "rate")
        }
    }
    
    
    
    @IBAction func videoTapGesture(_ sender: UITapGestureRecognizer) {
        videoControllersToggle = !videoControllersToggle
        if videoControllersToggle {
            controllersContainer.isHidden = false
            durationContainer.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                self.controllersContainer.isHidden = true
                self.durationContainer.isHidden = true
            }
        } else {
            controllersContainer.isHidden = true
            durationContainer.isHidden = true
        }
    }
    
    
    
    @IBAction func addCommentBtn(_ sender: UIButton) {
        
        guard let currentUserName = Auth.auth().currentUser?.displayName else { return }
        self.db.collection("dapim").document(self.dafName).collection("comments").document().setData([
            "owner_name": currentUserName,
            "time_of_comment": videoPlayer.currentTime().durationText,
            "content": self.newCommentStr])
        
        commentTextView.text = nil
    }
    
    
    private func setupAVPlayerObservers(_ avPlayer: AVPlayer) {
        avPlayer.addObserver(self, forKeyPath: "status", options: [.new, .old], context: nil)
        if #available(iOS 10.0, *) {
            avPlayer.addObserver(self, forKeyPath: "timeControlStatus", options: [.new, .old], context: nil)
        } else {
            avPlayer.addObserver(self, forKeyPath: "rate", options: [.new, .old], context: nil)
        }
        avPlayer.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
    }

    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is AVPlayer {

            switch keyPath {
                
            case "status":
                if videoPlayer.status == .readyToPlay {
                    //videoPlayer.play()
                }
            case "timeControlStatus":
                if #available(iOS 10.0, *) {
                    if videoPlayer.timeControlStatus == .playing {
                        print("video playing")
                        playPauseBtn.setBackgroundImage(UIImage(named: "pause_ic"), for: .normal)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                            self.controllersContainer.isHidden = true
                            self.durationContainer.isHidden = true
                        }
                    } else {
                        print("video paused")
                        playPauseBtn.setBackgroundImage(UIImage(named: "play_ic"), for: .normal)
                    }
                }
            case "rate":
                if videoPlayer.rate > 0 {
                    print("video playing")
                } else {
                    print("video paused")
                }
            default: break
            }
        }
        guard keyPath == "duration", let duration = self.videoPlayer.currentItem?.duration.seconds, duration > 0.0 else { return }
        self.durationTime.text = getTimeString(from: self.videoPlayer.currentItem!.duration)
        self.passedTime.text = getTimeString(from: self.videoPlayer.currentTime())
    }
    
    
    private func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours, minutes, seconds])
        } else {
            return String(format: "%02i:%02i", arguments: [minutes, seconds])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentSegue", let vc = segue.destination as? VideoComments_VC {
            vc.delegate = self
        }
    }
    
    
    
    @IBAction func backwardsBtn(_ sender: UIButton) {
        guard (videoPlayer.currentItem?.duration) != nil else { return }
        let currentTime = CMTimeGetSeconds(videoPlayer.currentTime())
        var newTime = currentTime - 5.0
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
        videoPlayer.seek(to: time)
    }
    
    @IBAction func playPauseBtn(_ sender: UIButton) {
        playPauseToggle = !playPauseToggle
        playPauseToggle ? videoPlayer.pause() : videoPlayer.play()
    }
    
    @IBAction func forwardBtn(_ sender: UIButton) {
        guard let duration = videoPlayer.currentItem?.duration else { return }
        let currentTime = CMTimeGetSeconds(videoPlayer.currentTime())
        let newTime = currentTime + 5.0
        if newTime <= (CMTimeGetSeconds(duration) - 5) {
            let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
            videoPlayer.seek(to: time)
        }
    }
}


extension Video_VC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("tv begun!!")
        if commentTextView.textColor != UIColor.black {
            commentTextView.textColor = UIColor.black
        }
        self.commentTextView.text = nil
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if newCommentStr.count > 0 {
            addNewCommentBtn.isHidden = false
        } else {
            addNewCommentBtn.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("tv ended!!")
        if commentTextView.textColor == UIColor.black {
            commentTextView.textColor = UIColor.lightGray
        }
        commentTextView.text = "add a comment..."
    }
}

extension Video_VC: DafNameDelegate {
    var daf_name: String {
        return self.dafName
    }
}
