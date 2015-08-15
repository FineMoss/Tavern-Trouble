//
//  RulesScene.swift
//  Tavern Trouble
//
//  Created by Jake Stephens on 6/21/15.
//  Copyright (c) 2015 Jake Stephens. All rights reserved.
//

import Foundation
import SpriteKit


class RulesScene: SKScene {
    
    let backButton = SKLabelNode(text: "Back")
    
    override func didMoveToView(view: SKView) {
        
        let backgroundImage = SKSpriteNode(imageNamed: "Background")
        let rulesLabel1 = SKLabelNode(text: "Collect the beer bottles with the spinner.")
        let rulesLabel2 = SKLabelNode(text: "Avoid the bottled water at all costs!")
        
        rulesLabel1.fontSize = 20
        rulesLabel2.fontSize = 20
        
        rulesLabel1.position = CGPointMake(0, self.frame.height * 0.3)
        rulesLabel2.position = CGPointMake(0, self.frame.height * 0.27)
        backButton.position = CGPointMake(-(self.frame.width * 0.34), (self.frame.height * 0.42))
        
        self.addChild(backgroundImage)
        self.addChild(backButton)
        self.addChild(rulesLabel1)
        self.addChild(rulesLabel2)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            
            if self.nodeAtPoint(touch.locationInNode(self)) == self.backButton {
                
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