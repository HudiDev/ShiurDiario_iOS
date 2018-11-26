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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func playVideoBtn(_ sender: Any) {
        guard let url = URL(string: "http://shiurdiario.com/media/video/Menachot_95.mp4") else { return }
        let video = AVPlayer(url: url)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        
        present(videoPlayer, animated: true) {
            video.play()
        }
    }

}
