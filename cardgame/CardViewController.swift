//
//  CardViewController.swift
//  cardgame
//
//  Created by calvin.chang on 2018/4/10.
//  Copyright © 2018年 calvin.chang. All rights reserved.
//

import UIKit
import GameplayKit

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
    
    var CardBt : [UIButton] = [UIButton]()
    
    let CardImage: [[UIImage]] = [
        [
            UIImage(named: "神奇寶貝球")!,
            UIImage(named: "小火龍.png")!,
            UIImage(named: "六尾.png")!,
            UIImage(named: "毛球.png")!,
            UIImage(named: "火暴猴.png")!,
            UIImage(named: "卡蒂狗.png")!,
            UIImage(named: "可达鸭.png")!,
            UIImage(named: "皮卡丘.png")!,
            UIImage(named: "皮皮.png")!,
            UIImage(named: "地鼠.png")!,
            UIImage(named: "妙蛙种子.png")!,
            UIImage(named: "走路草.png")!,
            UIImage(named: "凯西.png")!,
            UIImage(named: "杰尼龟.png")!,
            UIImage(named: "波波.png")!,
            UIImage(named: "阿柏蛇.png")!,
            UIImage(named: "胖丁.png")!,
            UIImage(named: "蚊香蝌蚪.png")!,
            UIImage(named: "迷你龙.png")!,
            UIImage(named: "喵喵.png")!,
            UIImage(named: "超音蝠.png")!,
//            UIImage(named: "peter.png")!
        ],
        [
            UIImage(named: "animal")!,
            UIImage(named: "animal1")!,
            UIImage(named: "animal2")!,
            UIImage(named: "animal3")!,
            UIImage(named: "animal4")!,
            UIImage(named: "animal5")!,
            UIImage(named: "animal6")!,
            UIImage(named: "animal7")!,
            UIImage(named: "animal8")!,
            UIImage(named: "animal9")!,
            UIImage(named: "animal10")!,
            UIImage(named: "animal11")!,
            UIImage(named: "animal12")!,
            UIImage(named: "animal13")!,
            UIImage(named: "animal14")!,
            UIImage(named: "animal15")!,
            UIImage(named: "animal16")!,
            UIImage(named: "animal17")!,
            UIImage(named: "animal18")!,
            UIImage(named: "animal19")!,
            UIImage(named: "animal20")!,
        ],
        [
            UIImage(named: "Transportation")!,
            UIImage(named: "Transportation1")!,
            UIImage(named: "Transportation2")!,
            UIImage(named: "Transportation3")!,
            UIImage(named: "Transportation4")!,
            UIImage(named: "Transportation5")!,
            UIImage(named: "Transportation6")!,
            UIImage(named: "Transportation7")!,
            UIImage(named: "Transportation8")!,
            UIImage(named: "Transportation9")!,
            UIImage(named: "Transportation10")!,
            UIImage(named: "Transportation11")!,
            UIImage(named: "Transportation12")!,
            UIImage(named: "Transportation13")!,
            UIImage(named: "Transportation14")!,
            UIImage(named: "Transportation15")!,
        ],
        [
            UIImage(named: "color")!,
            UIImage(named: "color1")!,
            UIImage(named: "color2")!,
            UIImage(named: "color3")!,
            UIImage(named: "color4")!,
            UIImage(named: "color5")!,
            UIImage(named: "color6")!,
            UIImage(named: "color7")!,
            UIImage(named: "color8")!,
            UIImage(named: "color9")!,
            UIImage(named: "color10")!,
        ],
    ]

    
    var AnswerCard: [Int] = [Int]()
    var gameStep:Int = 0
    var fristCard:Int = 0
    var secondCard:Int = 0
    var bingoNumber = 0
    var theme = 0
    
    var counter = 0.0
    var timer = Timer()
    var score = 0;
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CardBt.append(CardBt1)
        CardBt.append(CardBt2)
        CardBt.append(CardBt3)
        CardBt.append(CardBt4)
        CardBt.append(CardBt5)
        CardBt.append(CardBt6)
        CardBt.append(CardBt7)
        CardBt.append(CardBt8)
        CardBt.append(CardBt9)
        CardBt.append(CardBt10)
        CardBt.append(CardBt11)
        CardBt.append(CardBt12)
        CardBt.append(CardBt13)
        CardBt.append(CardBt14)
        CardBt.append(CardBt15)
        CardBt.append(CardBt16)
        CardBt.append(CardBt17)
        CardBt.append(CardBt18)
        CardBt.append(CardBt19)
        CardBt.append(CardBt20)
        
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

        switch gameStep{
        case 1:
            fristCard = cardNumber
            CardBt[fristCard].setImage(CardImage[theme][AnswerCard[fristCard]],for: UIControlState.normal)
            gameStep=2
        case 2:
            if(fristCard != cardNumber){
                secondCard = cardNumber
                CardBt[secondCard].setImage(CardImage[theme][AnswerCard[secondCard]],for: UIControlState.normal)
                gameStep=3
                
                if(AnswerCard[fristCard] == AnswerCard[secondCard]){
                    score+=100
                    bingoNumber+=1
                    
                    print("bingoNumber=\(bingoNumber)")
                    if(bingoNumber >= 10){
                        timer.invalidate()
                        gameStep=0
                        
                        for i in 0...(CardBt.count-1){
                            CardBt[i].setImage(CardImage[theme][AnswerCard[i]],for: UIControlState.normal)
                            CardBt[i].backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1.0, alpha: 1.0)
                            CardBt[i].isEnabled = true
                        }
                        
                        
                        let minutesLeft = Int(counter / 60) % 60
                        let secondsLeft = Int(counter) % 60
                        let minisecondsLeft = Int(counter*10) % 10
                        let total = score - Int(counter)
                        resultLable.isHidden=false
                        resultLable.text=String(format: "遊戲結果\n花費時間\n%02d:%02d.%01d\n\n得分\n%d\n\n總分\n%d", minutesLeft ,secondsLeft, minisecondsLeft,score,total)
                    }
                }else{
                    score-=10
                }
                scoreLable.text = String(format: "得分\n%04d", score)
            }
                            
        case 3:
            if(AnswerCard[fristCard] == AnswerCard[secondCard]){
                CardBt[fristCard].backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1.0, alpha: 0.0)
                CardBt[fristCard].setImage(nil,for: UIControlState.normal)
                CardBt[fristCard].isEnabled=false
                CardBt[secondCard].backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1.0, alpha: 0.0)
                CardBt[secondCard].setImage(nil,for: UIControlState.normal)
                CardBt[secondCard].isEnabled=false
                
                if((cardNumber != fristCard) && (cardNumber != secondCard)){
                    fristCard = cardNumber
                    CardBt[fristCard].setImage(CardImage[theme][AnswerCard[fristCard]],for: UIControlState.normal)
                    gameStep=2
                }
            }else{
                CardBt[fristCard].setImage(CardImage[theme][0],for: UIControlState.normal)
                CardBt[secondCard].setImage(CardImage[theme][0],for: UIControlState.normal)
                
                
                fristCard = cardNumber
                CardBt[fristCard].setImage(CardImage[theme][AnswerCard[fristCard]],for: UIControlState.normal)
                gameStep=2
            }
            
        default:
            gameStep = 0
        }
    }
    
    func creatTopic(){
        var cardBuf:[Int] = [Int]()
        let randomDistribution1 = GKRandomDistribution(lowestValue: 0, highestValue: CardImage.count - 1)
        theme = randomDistribution1.nextInt()
        
        let randomDistribution2 = GKShuffledDistribution(lowestValue: 1, highestValue:CardImage[theme].count-1)
        //產生十個問題index
        for _ in 0...9{
            cardBuf.append(randomDistribution2.nextInt())
        }
        
        //copy 十個問題index
        for i in 0...9{
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
        timeLable.text = String(format: "時間\n%02d:%02d.%01d", 0 ,0, 0)
        scoreLable.text = String(format: "得分\n%04d", 0)
        
          for i in 0...(CardBt.count-1){
//            CardBt[i].setImage(CardImage[theme][0],for: UIControlState.normal)
            CardBt[i].setImage(CardImage[theme][AnswerCard[i]],for: UIControlState.normal)
            CardBt[i].backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1.0, alpha: 1.0)
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
            timeLable.text = String(format: "時間\n%02d:%02d.%01d", minutesLeft ,secondsLeft, minisecondsLeft)
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
