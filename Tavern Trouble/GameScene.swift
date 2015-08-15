//
//  GameScene.swift
//  Tavern Trouble
//
//  Created by Jake Stephens on 5/20/15.
//  Copyright (c) 2015 Jake Stephens. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
   
    var bottlesCaught = 0
    var bottlesDropped = 0
    var bottlesCaughtLabel: SKLabelNode = SKLabelNode()
    
    let bob = SKSpriteNode(imageNamed: "Hero")
    
    let quitButton = SKLabelNode(text: "Quit")
    
    var score = 0
    
    let BobCategory: UInt32 = 0x1 << 0
    let BeerCategory: UInt32 = 0x1 << 1
    let BottomCategory: UInt32 = 0x1 << 2
    let WaterCategory: UInt32 = 0x1 << 3

    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVectorMake(0.0, -2.0)
        physicsWorld.contactDelegate = self
        
        /* Setup your scene here */
        addBG()
        addHero()
        addFloor()
        doBeerAction()
        
        var beerTimer = NSTimer.scheduledTimerWithTimeInterval(4.4, target: self, selector: "doBeerAction",
            userInfo: nil, repeats: true)
        
        var waterTimer = NSTimer.scheduledTimerWithTimeInterval(12.7, target: self, selector: "doWaterAction",
            userInfo: nil, repeats: true)
        
        addLabels()
    }
    
    func addLabels() {
        
        bottlesCaughtLabel.position = CGPointMake(-(self.frame.width * 0.23), (self.frame.height * 0.44))
        quitButton.position = CGPointMake((self.frame.width * 0.4), (self.frame.height * 0.44))
        
        bottlesCaughtLabel.fontSize = 20
        quitButton.fontSize = 20
       
        bottlesCaughtLabel.text = "Score: 0 Lives x 5"
        
        self.addChild(bottlesCaughtLabel)
        self.addChild(quitButton)
    }
    
    func doBeerAction() {
        
        let dropBottle = SKAction.sequence([
            SKAction.runBlock(addBeerBottle),
            SKAction.waitForDuration(NSTimeInterval(1.7))])
        let endlessAction = SKAction.repeatActionForever(dropBottle)
        runAction(endlessAction)
    }
    
    func doWaterAction() {
        
        let dropBottle = SKAction.sequence([
            SKAction.runBlock(addWaterBottle),
            SKAction.waitForDuration(NSTimeInterval(2.8))])
        let endlessAction = SKAction.repeatActionForever(dropBottle)
        runAction(endlessAction)
    }

    func addWaterBottle() {
        
        let water = SKSpriteNode(imageNamed: "Water")

        var randomNum = Double(arc4random_uniform(UInt32(self.frame.size.width - (water.size.width * 3))))
        var nextNum = Double((self.frame.size.width / 2) - water.size.width)
        var final = CGFloat(randomNum - nextNum)
        
        water.position = CGPointMake(final, self.frame.size.height * 0.39)
        
        water.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(water.size.width, water.size.height))
        water.physicsBody?.dynamic = true
        water.physicsBody!.categoryBitMask = WaterCategory
        water.physicsBody!.contactTestBitMask = BobCategory | BottomCategory
        water.physicsBody!.collisionBitMask = BobCategory | BottomCategory
        
        self.addChild(water)
    }
    
    func addBeerBottle(){
        
        let beer = SKSpriteNode(imageNamed: "Beer")
        
        var randomNum = Double(arc4random_uniform(UInt32(self.frame.size.width - (beer.size.width * 3))))
        var nextNum = Double((self.frame.size.width / 2) - beer.size.width)
        var final = CGFloat(randomNum - nextNum)
        
        beer.position = CGPointMake(final, self.frame.size.height * 0.39)
        
        beer.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(beer.size.width, beer.size.height))
        beer.physicsBody?.dynamic = true
        beer.physicsBody!.categoryBitMask = BeerCategory
        beer.physicsBody!.contactTestBitMask = BobCategory | BottomCategory
        beer.physicsBody!.collisionBitMask = BobCategory | BottomCategory
        
        self.addChild(beer)
    }
    
    func addBG() {
        
        let BG = SKSpriteNode(imageNamed: "Background")
        self.addChild(BG)
    }
    
    func addHero() {
        
        bob.position = CGPointMake(0, -(self.frame.height * 0.17))
        
        bob.physicsBody = SKPhysicsBody(circleOfRadius: bob.size.width / 2.0)
        bob.physicsBody!.dynamic = false
        bob.physicsBody!.affectedByGravity = false
        bob.physicsBody!.categoryBitMask = BobCategory
        bob.physicsBody!.contactTestBitMask = BeerCategory
        bob.physicsBody!.collisionBitMask = BeerCategory
        
        self.addChild(bob)
    }
    
    func addFloor(){
        
        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * 1.5, frame.size.height * 1.5)
        
        let bottom = SKNode()
        
        bottom.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        bottom.physicsBody?.dynamic = false
        bottom.physicsBody!.categoryBitMask = BottomCategory
        
        self.addChild(bottom)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        /* Called when a touch begins */
        for touch in (touches as! Set<UITouch>) {
            var touch = touches.first as! UITouch
            var touchLocation = touch.locationInNode(self)

            bob.position = CGPointMake(touchLocation.x, -(self.frame.height * 0.17))
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        // 1. Check whether user touched the paddle
        // 2. Get touch location
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        var previousLocation = touch.previousLocationInNode(self)
            
        // 3. Get node for paddle
        var paddle = bob
    
        // 4. Calculate new position along x for paddle
        var paddleX = paddle.position.x + (touchLocation.x - previousLocation.x)
        var paddleY = -(self.frame.height * 0.17)//paddle.position.y + (touchLocation.y - previousLocation.y)
            
        // 6. Update paddle position
        paddle.position = CGPointMake(paddleX, paddleY)
    }
   
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            if self.nodeAtPoint(touch.locationInNode(self)) == self.quitButton {
                
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
    
    func didBeginContact(contact: SKPhysicsContact) {
    
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
            
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == BeerCategory && secondBody.categoryBitMask == BottomCategory {
            
            firstBody.node?.removeFromParent()
            bottlesDropped++
            bottlesCaughtLabel.text = "Score: \(bottlesCaught) Lives x \(5 - bottlesDropped)"
            
            if bottlesDropped == 6 {
                
                var score = bottlesCaught

                let currentHighScore = userDefaults.objectForKey("highscore") as? Int
                let currentScore = userDefaults.objectForKey("currentScore") as? Int
                
                if score >= currentHighScore {
                    userDefaults.setValue(score, forKey: "highscore")
                    userDefaults.setValue(score, forKey: "currentScore")
                    userDefaults.synchronize()

                }
                else {
                    userDefaults.setValue(currentHighScore, forKey: "highscore")
                    userDefaults.setValue(score, forKey: "currentScore")
                    userDefaults.synchronize()
                }
                
                let scene = GameOverScene()
                let skView = self.view as SKView!
                skView.showsFPS = false
                skView.showsNodeCount = false
                skView.ignoresSiblingOrder = true
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
        }
        
        if firstBody.categoryBitMask == BottomCategory && secondBody.categoryBitMask == WaterCategory {
            
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.categoryBitMask == BobCategory && secondBody.categoryBitMask == WaterCategory {

            secondBody.node?.removeFromParent()
            bottlesCaught = bottlesCaught - 5
            bottlesCaughtLabel.text = "Score: \(bottlesCaught) Lives x \(5 - bottlesDropped)"
        }
        
        if firstBody.categoryBitMask == BobCategory && secondBody.categoryBitMask == BeerCategory {
            
            secondBody.node?.removeFromParent()
            bottlesCaught++
            bottlesCaughtLabel.text = "Score: \(bottlesCaught) Lives x \(5 - bottlesDropped)"
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        /* Called before each frame is rendered */
        bob.zRotation -= CGFloat(CDouble(15) * M_PI / 180)
    }
}