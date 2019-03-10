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

    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if prefix == nil { prefix = "Menachot_95" }
        
        videoTitle.text = dafName
        
        guard let url = URL(string: "http://shiurdiario.com/media/video/\(prefix!).mp4") else { return }
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        videoLayer.videoGravity = .resize
        videoView.layer.addSublayer(videoLayer)
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
    

    private func addConstraints(to videoView: UIView) {
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.topAnchor.constraint(equalTo: videoContainer.topAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: videoContainer.bottomAnchor).isActive = true
        videoView.centerXAnchor.constraint(equalTo: videoContainer.centerXAnchor).isActive = true
        videoView.widthAnchor.constraint(equalToConstant: 270.0).isActive = true
        videoView.layoutIfNeeded()
    }
    
}
