//
//  EndScene.swift
//  SA-Space-Fighter
//
//  Created by Todd Cardoso on 2016-05-27.
//  Copyright © 2016 TJC. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import UIKit
import CoreData

class EndScene : SKScene {
    

    var bgImage         = SKSpriteNode(imageNamed: "darkbg.jpg")
    let restartButton   = SKSpriteNode(imageNamed: "restartButton")
    var Highscore       : Int!
    var ScoreLbl        : UILabel!
    var HighScoreLbl    : UILabel!
    var endMusic        : AVAudioPlayer!
    
    
    override func didMove(to view: SKView) {
        
        
        func playEndMusic(){
            do {
                self.endMusic =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "menuMusic", ofType: "caf")!))
                self.endMusic?.prepareToPlay()
                self.endMusic?.volume = 0.3
                self.endMusic.play()
                
            } catch {
                print("Error")
            }
        }
        
        func addBackgroundImage(){
            bgImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bgImage.size.height = self.size.height
            bgImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            bgImage.zPosition = -0.5
            self.addChild(bgImage)
        }
        
        func addRestartButton(){
            restartButton.position = CGPoint(x: self.size.width / 2, y: self.size.height / 4)
            restartButton.xScale = 0.6
            restartButton.yScale = 0.6
            restartButton.zPosition = 1.0
            self.addChild(restartButton)
        }
        
        playEndMusic()
        addBackgroundImage()
        addRestartButton()

        let ScoreDefault = UserDefaults.standard
        let Score = ScoreDefault.value(forKey: "Score") as! NSInteger
        NSLog("Score: \(Score)")
        
        let HighscoreDefault = UserDefaults.standard
        Highscore = HighscoreDefault.value(forKey: "Highscore") as! NSInteger
        
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        ScoreLbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 2.2)
        ScoreLbl.textColor = UIColor.white
        ScoreLbl.adjustsFontSizeToFitWidth = true

        ScoreLbl.text = "Your Score: \(Score)"
        self.view?.addSubview(ScoreLbl)
        
        HighScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        HighScoreLbl.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 2.8)
        HighScoreLbl.textColor = UIColor.white
        HighScoreLbl.adjustsFontSizeToFitWidth = true
        HighScoreLbl.text = "Highscore: \(Highscore)"
        self.view?.addSubview(HighScoreLbl)
        
        NSLog("HighScore: \(Highscore)")
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch in (touches ){
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.restartButton {
                
                HighScoreLbl.removeFromSuperview()
                ScoreLbl.removeFromSuperview()

                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let letsPlay = PlayScene(size: self.size)
                self.view?.presentScene(letsPlay, transition: reveal)
                
            }
        }
        
    }
    
    
}
