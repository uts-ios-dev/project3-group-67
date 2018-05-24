//
//  SimpleViewController.swift
//  cardgame
//
//  Created by Jiayi Shi on 2018/5/20.
//  Copyright © 2018年 UTS. All rights reserved.
//

import UIKit
import GameplayKit

class SimpleViewController: UIViewController {

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
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var resultLable: UILabel!
    @IBOutlet weak var countdownLable: UILabel!
    @IBOutlet weak var baseBG: UIImageView!
    
    
    var CardBt : [UIButton] = [UIButton]()
    
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
        
        // Do any additional setup after loading the view.
        CardBt = [CardBt1, CardBt2, CardBt3, CardBt4, CardBt5, CardBt6, CardBt7, CardBt8, CardBt9, CardBt10, CardBt11, CardBt12]
        
        creatTopic()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func reStart(_ sender: Any) {
        creatTopic()
    }
    
    @IBAction func cardSelect(_ sender: UIButton) {
        var cardNumber:Int = 0
        
        for i in 0...(CardBt.count-1){
            if(sender.restorationIdentifier! == CardBt[i].restorationIdentifier!){
                cardNumber = i
                break
            }
        }
        UIView.transition(with: sender, duration: 0.2, options: .transitionFlipFromLeft, animations: {
            sender.setImage(UIImage(named:"bg_front"), for: .normal)
        }) { (finished) in
            switch self.gameStep{
            case 1:
                self.firstCard = cardNumber
                self.CardBt[self.firstCard].setImage(self.CardImage[self.theme][self.AnswerCard[self.firstCard]],for: UIControlState.normal)
                self.gameStep=2
            case 2:
                if(self.firstCard != cardNumber){
                    self.secondCard = cardNumber
                    self.CardBt[self.secondCard].setImage(self.CardImage[self.theme][self.AnswerCard[self.secondCard]],for: UIControlState.normal)
                    self.gameStep=3
                    
                    if(self.AnswerCard[self.firstCard] == self.AnswerCard[self.secondCard]){
                        self.score+=100
                        self.bingoNumber+=1
                        
                        //print("bingoNumber=\(bingoNumber)")
                        if(self.bingoNumber >= 5){
                            self.timer.invalidate()
                            self.gameStep=0
                            
                            for i in 0...(self.CardBt.count-1){
                                self.CardBt[i].setImage(self.CardImage[self.theme][self.AnswerCard[i]],for: UIControlState.normal)
                                self.CardBt[i].backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
                                self.CardBt[i].isEnabled = true
                            }
                            
                            
                            let minutesLeft = Int(self.counter / 60) % 60
                            let secondsLeft = Int(self.counter) % 60
                            let minisecondsLeft = Int(self.counter*10) % 10
                            let total = self.score - Int(self.counter)
                            self.resultLable.isHidden=false
                            self.resultLable.text=String(format: "Congratulations!\nGame Result\n\nTime Cosumed\n%02d:%02d.%01d\n\nScore\n%d\n\nTotal\n%d", minutesLeft ,secondsLeft, minisecondsLeft,self.score,total)
                        }
                    }else{
                        self.score-=10
                    }
                    self.scoreLable.text = String(format: "Score\n%04d", self.score)
                }
                
            case 3:
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
                        self.gameStep=2
                    }
                }else{
                    self.CardBt[self.firstCard].setImage(self.CardImage[self.theme][0],for: UIControlState.normal)
                    self.CardBt[self.secondCard].setImage(self.CardImage[self.theme][0],for: UIControlState.normal)
                    
                    
                    self.firstCard = cardNumber
                    self.CardBt[self.firstCard].setImage(self.CardImage[self.theme][self.AnswerCard[self.firstCard]],for: UIControlState.normal)
                    self.gameStep=2
                }
                
            default:
                self.gameStep = 0
            }
        }
        
    }
    
    func creatTopic(){
        var cardBuf:[Int] = [Int]()
        let randomDistribution1 = GKRandomDistribution(lowestValue: 0, highestValue: CardImage.count - 1)
        theme = randomDistribution1.nextInt()
        
        let randomDistribution2 = GKShuffledDistribution(lowestValue: 1, highestValue:CardImage[theme].count-1)
        //產生六個問題index
        for _ in 0...5{
            cardBuf.append(randomDistribution2.nextInt())
        }
        
        //copy 六個問題index
        for i in 0...5{
            cardBuf.append(cardBuf[i])
        }
        
        //亂數排序問題
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
        
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timeLable.text = String(format: "Time\n%02d:%02d.%01d", 0 ,0, 0)
        scoreLable.text = String(format: "Score\n%04d", 0)
        
        for i in 0...(CardBt.count-1){
            //            CardBt[i].setImage(CardImage[theme][0],for: UIControlState.normal)
            CardBt[i].setImage(CardImage[theme][AnswerCard[i]],for: UIControlState.normal)
            CardBt[i].backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
            CardBt[i].isEnabled=true
            
            if(theme == 3){
                CardBt[i].imageView!.contentMode = UIViewContentMode.scaleToFill
            }else{
                CardBt[i].imageView!.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        for bt in CardBt{
            bt.isEnabled=true
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
        }
        else{
            countdownLable.text = String(5 - Int(counter))
        }
    }
}

