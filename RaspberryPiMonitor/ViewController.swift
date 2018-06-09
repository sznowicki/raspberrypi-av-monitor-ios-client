//
//  ViewController.swift
//  RaspberryPiMonitor
//
//  Created by Szymon Nowicki on /03/0618.
//  Copyright © 2018 Szymon Nowicki. All rights reserved.
//

import UIKit
import MJPEGStreamLib

class ViewController: UIViewController {

    @IBOutlet var outlet: UIView!

    @IBOutlet weak var VideoStreamImage: UIImageView!
    
    @IBOutlet weak var PlayButton: UIButton!
    
    var isReady = false
    var stream: MJPEGStreamLib!
    
    override func viewWillAppear(_ animated: Bool) {
        // Z-index
        VideoStreamImage.isHidden = true
        if (!isReady) {
            PlayButton.isHidden = true
        }
        // TODO make it dynamic
        PlayButton.isHidden = false
        playStream()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startTouchUp(_ sender: Any) {
        playStream()
    }
    
    func playStream() {
        PlayButton.isHidden = true
        VideoStreamImage.isHidden = false
        guard let url = URL(string: "http://rpis.local:8080/?action=stream") else {
            return
        }
        // Set the ImageView to the stream object
        stream = MJPEGStreamLib(imageView: VideoStreamImage)
        stream.contentURL = url
        stream.play()
    }
    
}

