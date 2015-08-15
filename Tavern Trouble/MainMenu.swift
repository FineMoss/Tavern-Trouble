//
//  MainMenu.swift
//  Tavern Trouble
//
//  Created by Jake Stephens on 5/20/15.
//  Copyright (c) 2015 Jake Stephens. All rights reserved.
//

import SpriteKit


class MainMenu:SKScene {
    
    let playBttn = SKSpriteNode(imageNamed: "Play")
    let howToPlayLabel = SKLabelNode(text: "How To Play")

    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        let gameOverLabel = SKLabelNode(text: "Tavern Trouble")
        let backgroundImage = SKSpriteNode(imageNamed: "Background")
        
        var highScoreLabel : SKLabelNode = SKLabelNode()
        var currentScoreLabel : SKLabelNode = SKLabelNode()

        highScoreLabel.position = CGPointMake(0, -(self.frame.height * 0.2))
        gameOverLabel.position = CGPointMake(0, (self.frame.height * 0.2))
        howToPlayLabel.position = CGPointMake(0, self.frame.height * 0.4)

        self.addChild(backgroundImage)
        self.addChild(playBttn)
        self.addChild(highScoreLabel)
        self.addChild(gameOverLabel)
        self.addChild(currentScoreLabel)
        self.addChild(howToPlayLabel)
        
        
        if let highscore: AnyObject = userDefaults.objectForKey("highscore") as? Int {
            highScoreLabel.text = "HighScore: \(highscore)"
        }
        
        else {
            highScoreLabel.text = "Play Tavern Trouble!"
        }
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
            
            if self.nodeAtPoint(touch.locationInNode(self)) == self.howToPlayLabel {
            
                let scene = RulesScene()
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