//
//  ViewController.swift
//  RaspberryPiMonitor
//
//  Created by Szymon Nowicki on /03/0618.
//  Copyright © 2018 Szymon Nowicki. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet var outlet: UIView!

    @IBOutlet weak var PlayButton: UIButton!
    var isReady = false
    override func viewWillAppear(_ animated: Bool) {
        if (!isReady) {
            PlayButton.isHidden = true
        }
        // TODO make it dynamic
        PlayButton.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playVideo(_ sender: UIButton) {
        guard let url = URL(string: "http://www.html5videoplayer.net/videos/toystory.mp4") else {
            return
        }
        outlet.alpha = 0.75
        outlet.layer.zPosition = 0
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = false
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = view.frame
    
        view.layer.addSublayer(playerLayer)

        player.play()
        PlayButton.isHidden = true
    }
    
}

