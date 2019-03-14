//
//  Video_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit
import AVKit

class Video_VC: UIViewController {
    
    var prefix: String?
    var dafName: String!
    
    var videoPlayer: AVPlayer!
    var videoLayer: AVPlayerLayer!

    
    @IBOutlet weak var commentLabelSection: UIView!
    @IBOutlet weak var commentSection: UIView!
    @IBOutlet weak var commentSection_bottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoTitle: UILabel!
    //@IBOutlet weak var commentTextView: UITextView!
    
    @IBAction func addCommentBtn(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyBoardWhenTouchedAround()
        
        if prefix == nil { prefix = "Menachot_95" }
        
        videoTitle.text = dafName
        
        guard let url = URL(string: "http://shiurdiario.com/media/video/\(prefix!).mp4") else { return }
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        videoLayer.videoGravity = .resize
        videoView.layer.addSublayer(videoLayer)
        
        commentLabelSection.layer.borderWidth = 0.4
        commentLabelSection.layer.borderColor = UIColor.black.cgColor
        
//        NotificationCenter.default.addObserver(self, selector: #selector(displayInputView), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(hideInputView), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
