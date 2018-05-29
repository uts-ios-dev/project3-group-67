//
//  ViewController.swift
//  cardgame
//
//  Created by Jiayi Shi on 2018/4/5.
//  Copyright © 2018年 UTS. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var AudioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: "Home", withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            
            /// for iOS 11 onward, use :
            AudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            AudioPlayer!.prepareToPlay()
            AudioPlayer!.numberOfLoops = -1
            AudioPlayer!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AudioPlayer!.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

