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
    
    var videoPlayer: AVPlayer!
    var videoLayer: AVPlayerLayer!
    private var db: Firestore!
    
    @IBOutlet weak var commentLabelSection: UIView!
    @IBOutlet weak var commentSection: UIView!
    @IBOutlet weak var commentSection_bottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var addNewCommentBtn: UIButton!
    
    var newCommentStr: String! {
        return commentTextView.text
    }
    
    @IBAction func addCommentBtn(_ sender: UIButton) {
        
        guard let currentUserName = Auth.auth().currentUser?.displayName else { return }
        self.db.collection("dapim").document(self.dafName).collection("comments").document().setData([
            "owner_name": currentUserName,
            "time_of_comment": videoPlayer.currentTime().durationText,
            "content": self.newCommentStr])
        
        commentTextView.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        //self.hideKeyBoardWhenTouchedAround()
        
        if prefix == nil { prefix = "Menachot_95" }
        
        videoTitle.text = dafName
        
        guard let url = URL(string: "http://shiurdiario.com/media/video/\(prefix!).mp4") else { return }
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        videoLayer.videoGravity = .resize
        videoView.layer.addSublayer(videoLayer)
        
        commentLabelSection.layer.borderWidth = 0.4
        commentLabelSection.layer.borderColor = UIColor.black.cgColor
        commentTextView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentSegue", let vc = segue.destination as? VideoComments_VC {
            vc.delegate = self
        }
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints(to: videoView)
        videoLayer.frame = videoView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer.play()
    }
    
    @objc func displayInputView(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.commentSection_bottomAnchor.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hideInputView(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.commentSection_bottomAnchor.constant = 0
            self.view.layoutIfNeeded()
        }
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

extension CMTime {
    var durationText:String {
        let totalSeconds = CMTimeGetSeconds(self)
        let hours:Int = Int(totalSeconds / 3600)
        let minutes:Int = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds:Int = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}


extension Video_VC: DafNameDelegate {
    var daf_name: String {
        return self.dafName
    }
}
