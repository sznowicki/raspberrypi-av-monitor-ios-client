//
//  ViewController.swift
//  RaspberryPiMonitor
//
//  Created by Szymon Nowicki on /03/0618.
//  Copyright © 2018 Szymon Nowicki. All rights reserved.
//

import UIKit
import AVKit
import MJPEGStreamLib

class ViewController: UIViewController {

    @IBOutlet var outlet: UIView!

    @IBOutlet weak var VideoStreamImage: UIImageView!
    
    @IBOutlet weak var PlayButton: UIButton!
    
    @IBOutlet weak var SkipToRT: UIButton!
    
    var isReady = false
    var VideoPlayer: MJPEGStreamLib!
    var AudioPlayer: AVPlayer?
    
    override func viewWillAppear(_ animated: Bool) {
        VideoPlayer = MJPEGStreamLib(imageView: VideoStreamImage)
        // Z-index
        VideoStreamImage.isHidden = true
        if (!isReady) {
            PlayButton.isHidden = true
            SkipToRT.isHidden = true
        }
        // TODO make it dynamic
        PlayButton.isHidden = false
    
        executeRepeatedly()
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
        playVideo()
    }
    @IBAction func skipToRealTimeButtonClick() {
        audioSkip();
    }
    
    func reload() {
        // TODO: check if is playing, reload only if not
        stopVideo()
        playVideo()
        
        stopAudio()
        playAudio()
    }
    func playVideo() {
        PlayButton.isHidden = true
        VideoStreamImage.isHidden = false
        guard let url = URL(string: "http://rpis.local:8080/?action=stream") else {
            return
        }
        // Set the ImageView to the stream object
        VideoPlayer.contentURL = url
        VideoPlayer.play()
    }
    
    func playAudio() {
        guard let url = URL(string: "http://rpis.local:8081/audio.mp3") else {
            return
        }
        AudioPlayer = AVPlayer(url: url)
        AudioPlayer?.play()
    }
    
    func stopAll() {
        stopVideo()
        stopAudio()
    }
    
    func stopVideo() {
        VideoPlayer?.stop()
    }
    
    func stopAudio() {
        AudioPlayer?.pause()
    }
    
    func audioSkip() {
        guard let durationTime = AudioPlayer?.currentItem?.duration else { return }
        
        // Percentage of duration
        let percentage = Float64(1)
        let percentageTime = CMTimeMultiplyByFloat64(durationTime, percentage)
        
        guard percentageTime.isValid && percentageTime.isNumeric else { return }
        
        // Percentage plust current time
        var targetTime = AudioPlayer!.currentTime() + percentageTime
        targetTime = targetTime.convertScale(durationTime.timescale, method: .default)
        
        // Sanity checks
        guard targetTime.isValid && targetTime.isNumeric else { return }
        
        if targetTime > durationTime {
            targetTime = durationTime // seek to end
        }
        
        AudioPlayer!.seek(to: targetTime)
    }
    
    func executeRepeatedly() {
        reload()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 180) { [weak self] in
            self?.executeRepeatedly()
        }
    }
    
}

