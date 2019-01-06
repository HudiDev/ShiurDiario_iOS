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

    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var containerUiVIew: UIView!
    @IBOutlet weak var imageBG: UIImageView!
    @IBOutlet weak var btnContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDesigns()
        videoTitle.text = dafName
    }

    
    @IBAction func playVideoBtn(_ sender: Any) {
        playBtn.alpha = 0.15
        if prefix == nil {
            prefix = "Menachot_95"
        }
        print("PREFIX OF VIDEO IS: \(prefix!)")
        guard let url = URL(string: "http://shiurdiario.com/media/video/\(prefix!).mp4") else { return }
        let video = AVPlayer(url: url)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video

        present(videoPlayer, animated: true) {
            video.play()
        }
    }
    
    private func UIDesigns() {
        imageBG.alpha = CGFloat(0.8)
        containerUiVIew.addBorder(width: 0.5, color: UIColor.white.cgColor)
        containerUiVIew.alpha = CGFloat(0.5)
        containerUiVIew.layer.cornerRadius = 15
    }
}
