//
//  GameOverScene.swift
//  Tavern Trouble
//
//  Created by Jake Stephens on 6/20/15.
//  Copyright (c) 2015 Jake Stephens. All rights reserved.
//

import Foundation

import SpriteKit

let userDefaults = NSUserDefaults.standardUserDefaults()

class GameOverScene: SKScene {
    
    let playBttn = SKSpriteNode(imageNamed: "Play")
    let mainMenuButton = SKLabelNode(text: "Main Menu")
    
    override func didMoveToView(view: SKView) {
        
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.position = CGPointMake(0, (self.frame.height * 0.2))
        
        let backgroundImage = SKSpriteNode(imageNamed: "Background")
        
        var highScore: AnyObject? = userDefaults.objectForKey("highscore") as! Int
        var currentScore: AnyObject? = userDefaults.objectForKey("currentScore") as! Int
        
        var highScoreLabel = SKLabelNode(text: "High Score: \(highScore!.integerValue)")
        var currentScoreLavel = SKLabelNode(text: "You Scored: \(currentScore!.integerValue)")

        highScoreLabel.position = CGPointMake(0, -(self.frame.height * 0.2))
        currentScoreLavel.position = CGPointMake(0, -(self.frame.height * 0.3))
        mainMenuButton.position = CGPointMake(0, -(self.frame.height * 0.46))
        
        self.addChild(backgroundImage)
        self.addChild(playBttn)
        self.addChild(highScoreLabel)
        self.addChild(gameOverLabel)
        self.addChild(currentScoreLavel)
        self.addChild(mainMenuButton)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    
        for touch in (touches as! Set<UITouch>) {
            
            if self.nodeAtPoint(touch.locationInNode(self)) == self.playBttn {
                
                let scene = GameScene()
                let skView = self.view as SKView!
                skView.showsFPS = false
                skView.showsNodeCount = false
                skView.ignoresSiblingOrder = true
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
            
            if self.nodeAtPoint(touch.locationInNode(self)) == self.mainMenuButton {
                
                let scene = MainMenu()
                let skView = self.view as SKView!
                skView.showsFPS = false
                skView.showsNodeCount = false
                skView.ignoresSiblingOrder = true
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
        }
    }
}