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
    
    var newCommentStr: String! {
        return commentTextView.text
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addConstraints(for: self.controllersContainer)
        
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
        
        self.observer = self.videoPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 600), queue: .main, using: {
            [weak self] time in
            if self?.videoPlayer.currentItem?.status == AVPlayerItemStatus.readyToPlay {
                if let isPlaybackLikelyToKeepUp = self?.videoPlayer.currentItem?.isPlaybackLikelyToKeepUp {
                    self?.videoLoaderIndicator.stopAnimating()
                } else {
                    self?.videoLoaderIndicator.startAnimating()
                }
            } else {
                self?.videoLoaderIndicator.startAnimating()
            }
        })
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints(to: videoView)
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
        } else {
            controllersContainer.isHidden = true
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentSegue", let vc = segue.destination as? VideoComments_VC {
            vc.delegate = self
        }
    }
    
    
   
    
    
    
    
    @IBAction func backwardsBtn(_ sender: UIButton) {
    }
    
    @IBAction func playPauseBtn(_ sender: UIButton) {
        playPauseToggle = !playPauseToggle
        playPauseToggle ? videoPlayer.pause() : videoPlayer.play()
    }
    
    @IBAction func forwardBtn(_ sender: UIButton) {
    }
    
    
    private func addConstraints(for container: UIStackView) {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 30).isActive = true
        container.widthAnchor.constraint(equalToConstant: 170).isActive = true
        container.centerXAnchor.constraint(equalTo: self.videoView.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.videoView.centerYAnchor).isActive = true
        
    }
    
    private func addConstraints(to videoView: UIView) {
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.topAnchor.constraint(equalTo: videoContainer.topAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: videoContainer.bottomAnchor).isActive = true
        videoView.centerXAnchor.constraint(equalTo: videoContainer.centerXAnchor).isActive = true
        videoView.widthAnchor.constraint(equalToConstant: 270.0).isActive = true
        videoView.layoutIfNeeded()
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
