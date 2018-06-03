//
//  Player.swift
//  RaspberryPiMonitor
//
//  Created by Szymon Nowicki on /03/0618.
//  Copyright © 2018 Szymon Nowicki. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class Player {
    static func play(href: String) {
        guard let url = URL(string: href) else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
    
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
    
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }
}
