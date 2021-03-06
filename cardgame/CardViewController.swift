//
//  CardViewController.swift
//  cardgame
//
//  Created by Jiayi Shi on 2018/5/20.
//  Copyright © 2018年 UTS. All rights reserved.
//

import UIKit
import GameplayKit
import AVFoundation

class CardViewController: UIViewController {
    
    @IBOutlet weak var CardBt1: UIButton!
    @IBOutlet weak var CardBt2: UIButton!
    @IBOutlet weak var CardBt3: UIButton!
    @IBOutlet weak var CardBt4: UIButton!
    @IBOutlet weak var CardBt5: UIButton!
    @IBOutlet weak var CardBt6: UIButton!
    @IBOutlet weak var CardBt7: UIButton!
    @IBOutlet weak var CardBt8: UIButton!
    @IBOutlet weak var CardBt9: UIButton!
    @IBOutlet weak var CardBt10: UIButton!
    @IBOutlet weak var CardBt11: UIButton!
    @IBOutlet weak var CardBt12: UIButton!
    @IBOutlet weak var CardBt13: UIButton!
    @IBOutlet weak var CardBt14: UIButton!
    @IBOutlet weak var CardBt15: UIButton!
    @IBOutlet weak var CardBt16: UIButton!
    @IBOutlet weak var CardBt17: UIButton!
    @IBOutlet weak var CardBt18: UIButton!
    @IBOutlet weak var CardBt19: UIButton!
    @IBOutlet weak var CardBt20: UIButton!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var resultLable: UILabel!
    @IBOutlet weak var countdownLable: UILabel!
    @IBOutlet weak var baseBG: UIImageView!
    
    var AudioPlayer: AVAudioPlayer?
    var FlippingSound: AVAudioPlayer?
    var CardBt : [UIButton] = [UIButton]()
    
    // 3 themes: Animals, Vegetables, Fruits
    let CardImage: [[UIImage]] = [
        [
            UIImage(named: "background.png")!,
            UIImage(named: "COW.png")!,
            UIImage(named: "elephant.png")!,
            UIImage(named: "giraffe.png")!,
            UIImage(named: "KOALA.png")!,
            UIImage(named: "panda.png")!,
            UIImage(named: "PIG.png")!,
            UIImage(named: "tiger.png")!,
            UIImage(named: "shark.png")!,
            UIImage(named: "lion.png")!,
            UIImage(named: "sheep.png")!,
        ],
        [
            UIImage(named: "background.png")!,
            UIImage(named: "carrot.png")!,
            UIImage(named: "garlic.png")!,
            UIImage(named: "ginger.png")!,
            UIImage(named: "pumpkin.png")!,
            UIImage(named: "wombok.png")!,
            UIImage(named: "corn.png")!,
            UIImage(named: "eggplant.png")!,
            UIImage(named: "mushroom.png")!,
            UIImage(named: "potato.png")!,
            UIImage(named: "tomato.png")!,
        ],
        [
            UIImage(named: "background.png")!,
            UIImage(named: "apple.png")!,
            UIImage(named: "banana.png")!,
            UIImage(named: "cherry.png")!,
            UIImage(named: "grape.png")!,
            UIImage(named: "kiwi.png")!,
            UIImage(named: "peach.png")!,
            UIImage(named: "pear.png")!,
            UIImage(named: "pineapple.png")!,
            UIImage(named: "strawberry.png")!,
            UIImage(named: "watermelon.png")!,
        ],
    ]

    // Initialize
    var AnswerCard: [Int] = [Int]()
    var gameStep:Int = 0
    var firstCard:Int = 0
    var secondCard:Int = 0
    var bingoNumber = 0
    var theme = 0
    
    var counter = 0.0
    var timer = Timer()
    var score = 0;
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        baseBG.image = #imageLiteral(resourceName: "BaseBG")
        CardBt = [CardBt1, CardBt2, CardBt3, CardBt4, CardBt5, CardBt6, CardBt7, CardBt8, CardBt9, CardBt10, CardBt11, CardBt12, CardBt13, CardBt14, CardBt15, CardBt16, CardBt17, CardBt18, CardBt19, CardBt20]
        
        // avoid adjusting button image when the button is disabled
        for Bt in CardBt {
            Bt.adjustsImageWhenDisabled=false
        }
        guard let url = Bundle.main.url(forResource: "Game", withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            // this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // for iOS 11 onward, use :
            AudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            AudioPlayer!.prepareToPlay()
            AudioPlayer!.numberOfLoops = -1
            AudioPlayer!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        creatTopic()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AudioPlayer!.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func reStart(_ sender: Any) {
        creatTopic()
    }
    
    @IBAction func cardSelect(_ sender: UIButton) {
        var cardNumber:Int = 0
        playSound()
        
        for i in 0...(CardBt.count-1){
            if(sender.restorationIdentifier! == CardBt[i].restorationIdentifier!){
                cardNumber = i
                break
            }
        }
        
        // enable card flipping animation
        UIView.transition(with: sender, duration: 0.2, options: .transitionFlipFromLeft, animations: {
            sender.setImage(UIImage(named:"bg_front"), for: .normal)
        }) { (finished) in
            switch self.gameStep{
            case 1:
                self.firstCard = cardNumber
                self.CardBt[self.firstCard].setImage(self.CardImage[self.theme][self.AnswerCard[self.firstCard]],for: UIControlState.normal)
                self.gameStep=2
               // disable touch event of the first card
                self.CardBt[self.firstCard].isEnabled=false
            case 2:
                if(self.firstCard != cardNumber){
                    self.secondCard = cardNumber
                    self.CardBt[self.secondCard].setImage(self.CardImage[self.theme][self.AnswerCard[self.secondCard]],for: UIControlState.normal)
                    self.gameStep=3
                    
                    if(self.AnswerCard[self.firstCard] == self.AnswerCard[self.secondCard]){
                        self.score+=100
                        self.bingoNumber+=1
                        
                        // detect the end of the game
                        if(self.bingoNumber >= 10){
                            self.timer.invalidate()
                            self.gameStep=0
                            
                            // display all cards when game over
                            for i in 0...(self.CardBt.count-1){
                                self.CardBt[i].setImage(self.CardImage[self.theme][self.AnswerCard[i]],for: UIControlState.normal)
                                self.CardBt[i].backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
                                self.CardBt[i].isEnabled = false
                            }
                            
                            // display result label
                            let minutesLeft = Int(self.counter / 60) % 60
                            let secondsLeft = Int(self.counter) % 60
                            let minisecondsLeft = Int(self.counter*10) % 10
                            let total = self.score - Int(self.counter)
                            self.resultLable.isHidden=false
                            let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
                            let textAttachment : NSTextAttachment = NSTextAttachment()
                            
                            // three-star ranking based on total scores
                            if (total>=950) {
                                textAttachment.image = #imageLiteral(resourceName: "threeStar")
                            } else if (total>=850){
                                textAttachment.image = #imageLiteral(resourceName: "twoStar")
                            }else {
                                textAttachment.image = #imageLiteral(resourceName: "oneStar")
                            }
                            textAttachment.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: self.view.frame.width/4.2)
                            let timeConsumed = String(format:"%02d:%02d.%01d",minutesLeft ,secondsLeft, minisecondsLeft)
                            let scoreShown = String(format:"%d",self.score)
                            let totalScoreShown = String(format:"%d",total)
                            let subString1 : NSAttributedString = NSAttributedString(string:"\nTime Cosumed\n")
                            let subString2 : NSAttributedString = NSAttributedString(string:timeConsumed)
                            let subString3 : NSAttributedString = NSAttributedString(string:"\n\nScore\n")
                            let subString4 : NSAttributedString = NSAttributedString(string:scoreShown)
                            let subString5 : NSAttributedString = NSAttributedString(string:"\n\nTotal\n")
                            let subString6 : NSAttributedString = NSAttributedString(string:totalScoreShown)
                            attributedStrM.append(NSAttributedString(attachment: textAttachment))
                            attributedStrM.append(subString1)
                            attributedStrM.append(subString2)
                            attributedStrM.append(subString3)
                            attributedStrM.append(subString4)
                            attributedStrM.append(subString5)
                            attributedStrM.append(subString6)
                            self.resultLable.attributedText=attributedStrM
                        }else{
                            self.CardBt[self.firstCard].isEnabled=true
                        }
                    }else{
                        self.score-=10
                        self.CardBt[self.firstCard].isEnabled=true
                    }
                    self.scoreLable.text = String(format: "Score\n%04d", self.score)
                }
                
            case 3:
                // make the bingo cards disappear
                if(self.AnswerCard[self.firstCard] == self.AnswerCard[self.secondCard]){
                    self.CardBt[self.firstCard].backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 0.0)
                    self.CardBt[self.firstCard].setImage(nil,for: UIControlState.normal)
                    self.CardBt[self.firstCard].isEnabled=false
                    self.CardBt[self.secondCard].backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 0.0)
                    self.CardBt[self.secondCard].setImage(nil,for: UIControlState.normal)
                    self.CardBt[self.secondCard].isEnabled=false
                    
                    if((cardNumber != self.firstCard) && (cardNumber != self.secondCard)){
                        self.firstCard = cardNumber
                        self.CardBt[self.firstCard].setImage(self.CardImage[self.theme][self.AnswerCard[self.firstCard]],for: UIControlState.normal)
                        self.CardBt[self.firstCard].isEnabled=false
                        self.gameStep=2
                    }
                }else{
                    self.CardBt[self.firstCard].setImage(self.CardImage[self.theme][0],for: UIControlState.normal)
                    self.CardBt[self.secondCard].setImage(self.CardImage[self.theme][0],for: UIControlState.normal)
                    
                    
                    self.firstCard = cardNumber
                    self.CardBt[self.firstCard].setImage(self.CardImage[self.theme][self.AnswerCard[self.firstCard]],for: UIControlState.normal)
                    self.CardBt[self.firstCard].isEnabled=false
                    self.gameStep=2
                }
                
            default:
                self.gameStep = 0
            }
        }
        
    }
    
    func creatTopic(){
        var cardBuf:[Int] = [Int]()
        // GKRandomDistribution avoids Int32 transformation of arc4random_uniform
        let randomDistribution1 = GKRandomDistribution(lowestValue: 0, highestValue: CardImage.count - 1)
        theme = randomDistribution1.nextInt()
        
        let randomDistribution2 = GKShuffledDistribution(lowestValue: 1, highestValue:CardImage[theme].count-1)
        // Generate 10 distinct indexes
        for _ in 0...9{
            cardBuf.append(randomDistribution2.nextInt())
        }
        
        // duplicate the first 10 distinct indexes
        for i in 0...9{
            cardBuf.append(cardBuf[i])
        }
        
        // reshuffle total 20 indexes
        AnswerCard.removeAll()
        let randomDistribution3 = GKShuffledDistribution(lowestValue: 0, highestValue:cardBuf.count-1)
        for _ in 0...(cardBuf.count-1){
            AnswerCard.append(cardBuf[randomDistribution3.nextInt()])
        }
        
        gameStep = 0
        bingoNumber = 0
        counter = 0.0
        score = 0
        resultLable.isHidden=true
        
        countdownLable.isHidden=false
        
        timeLable.text = String(format: "Time\n%02d:%02d.%01d", 0 ,0, 0)
        scoreLable.text = String(format: "Score\n%04d", 0)
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
          for i in 0...(CardBt.count-1){
            CardBt[i].setImage(CardImage[theme][AnswerCard[i]],for: UIControlState.normal)
            CardBt[i].backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
            // disable card flipping before finishing countdown
            CardBt[i].isEnabled=false
                CardBt[i].imageView!.contentMode = UIViewContentMode.scaleAspectFit
        }

    }
    
    @objc func updateTimer() {
        counter+=0.1
        
        if(gameStep > 0){
            let minutesLeft = Int(counter / 60) % 60
            let secondsLeft = Int(counter) % 60
            let minisecondsLeft = Int(counter*10) % 10
            timeLable.text = String(format: "Time\n%02d:%02d.%01d", minutesLeft ,secondsLeft, minisecondsLeft)
        }else if(counter > 5.5) && (gameStep == 0){
            counter = 0.0
            gameStep = 1
            for i in 0...(CardBt.count-1){
               CardBt[i].setImage(CardImage[theme][0],for: UIControlState.normal)
            }
            countdownLable.isHidden=true
            // enable card flipping when finishing countdown
            for bt in CardBt{
                bt.isEnabled=true
            }
        }
        else{
             countdownLable.text = String(5 - Int(counter))
        }
    }
    // sound effect when flipping card
    func playSound(){
        guard let url = Bundle.main.url(forResource: "Flipping", withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            // this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            // for iOS 11 onward, use :
            FlippingSound = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            FlippingSound!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
}
