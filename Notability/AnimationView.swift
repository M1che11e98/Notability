//import UIKit
//import SwiftUI
//import SpriteKit
//
//class GameScene: SKScene, SKPhysicsContactDelegate {
//    
//    enum CollisionTypes: UInt32 {
//        case Circle = 1
//        case Ball = 2
//        //case Enemy1 = 4
//        //case Enemy2 = 8
//        //case Enemy3 = 16
//        //case EnemyBoss = 32
//    }
//    
//    var circulo: SKSpriteNode!
//    var padding: CGFloat = 40.0
//    var center: CGPoint!
//    
////    override func didMoveToView() {
//        
//        self.physicsWorld.gravity = CGVectorMake(0, -6)
//        self.physicsWorld.contactDelegate = self
//        self.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
//        
//        // Prepare circle
//        circulo = SKSpriteNode(imageNamed: "circuloFondo2.png")
//        //Circle that I want the ball bounce within
//        circulo.size = CGSize(width:view.frame.size.width - padding , height: view.frame.size.width - padding)
//        let circlePath = UIBezierPath(arcCenter: self.center, radius: (view.frame.size.width - padding*2)/2, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
//        circulo.color = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
//        circulo.colorBlendFactor = 1
//        circulo.alpha = 1
//        circulo.position = self.center
//        circulo.zPosition = 1
//        
//        // Set physics
//        let circuloBody = SKPhysicsBody.init(edgeLoopFromPath: circlePath.CGPath)
//        self.physicsBody = circuloBody
//        self.physicsBody!.affectedByGravity = false
//        self.physicsBody!.usesPreciseCollisionDetection = true
//        self.physicsBody!.isDynamic = true
//        self.physicsBody!.mass = 0
//        self.physicsBody!.friction = 0
//        self.physicsBody!.linearDamping = 0
//        self.physicsBody!.angularDamping = 0
//        self.physicsBody!.restitution = 1
//        self.physicsBody!.categoryBitMask = CollisionTypes.Circle.rawValue
//        self.physicsBody!.contactTestBitMask = CollisionTypes.Ball.rawValue
//        //self.circulo.physicsBody!.collisionBitMask = 0
//        
//        self.addChild(circulo)
//        
//        
//        //Prepare ball
//        let ball = SKShapeNode(circleOfRadius: 9)
//        ball.fillColor = SKColor.white
//        ball.position = self.center
//        ball.zPosition = 1
//        
//        // Set physics
//        ball.physicsBody = SKPhysicsBody(circleOfRadius: 9)
//        ball.physicsBody!.affectedByGravity = true
//        ball.physicsBody!.restitution = 0.8
//        ball.physicsBody!.linearDamping = 0
//        ball.physicsBody!.friction = 0.3
//        ball.physicsBody?.isDynamic = true
//        ball.physicsBody!.mass = 0.5
//        ball.physicsBody!.allowsRotation = true
//        ball.physicsBody!.categoryBitMask = CollisionTypes.Ball.rawValue
//        ball.physicsBody!.contactTestBitMask = CollisionTypes.Circle.rawValue
//        //ball.physicsBody!.collisionBitMask = 0
//        
//        self.addChild(ball)
//        
//    }
//    
//    func didBeginContact(contact: SKPhysicsContact) {
//        // elements
//        if (contact.bodyA.categoryBitMask == CollisionTypes.Circle.rawValue &&
//            contact.bodyB.categoryBitMask == CollisionTypes.Ball.rawValue) {
//            print("contact between circle and ball")
//        }
//    }
////}
//
//struct AnimationView: View {
//    
//    var body: some View {
//        
//       Text("hello")
//        
//        
//    }
//}
//    
//    struct AnimationView_Previews: PreviewProvider {
//        static var previews: some View {
//            AnimationView()
//        }
//    }
