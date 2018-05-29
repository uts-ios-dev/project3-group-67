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
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Home", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer!.prepareToPlay()
        AudioPlayer!.numberOfLoops = -1
        AudioPlayer!.play()
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

