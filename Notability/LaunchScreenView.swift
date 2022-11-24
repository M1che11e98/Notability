////
////  LaunchScreenView.swift
////  Notability
////
////  Created by Marta Michelle Caliendo on 22/11/22.
////
//
//import SwiftUI
//import SpriteKit
//
////class GameScene: SKScene {
////    override func didMove(to view: SKView) {
////        var scoreLabel: SKLabelNode!
////        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
////        scoreLabel.text = "📝"
////        scoreLabel.horizontalAlignmentMode = .center
////        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
////        addChild(scoreLabel)
////        let fadeAction = SKAction.fadeAlpha(to: 0.5, duration: 1)
////        scoreLabel.run(fadeAction)
////
//class GameScene: SKScene {
//    override func didMove(to view: SKView) {
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//        
////
////        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue:
////                                        0.95, alpha: 1.0)  //funzione per dare un colore al background
//        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//                    guard let touch = touches.first else {return}
//                    let location = touch.location(in: self)
//                    let ball = SKSpriteNode(imageNamed: "pic1")
//                    ball.size = CGSize(width: 70, height: 150)
//                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.7)
//                    ball.physicsBody?.restitution = 0.4
//                    ball.position = location
//                    addChild(ball)
//            
//                }
//        func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//                guard let touch = touches.first else {return}
//                let location = touch.location(in: self)
//                let ball = SKSpriteNode(imageNamed: "ball")
//                ball.size = CGSize(width: 40, height: 40)
//                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.7) //
//                ball.physicsBody?.restitution = 0.4
//                ball.position = location
//                addChild(ball)
//            }
//        
//        
//        let pencil = SKSpriteNode(imageNamed: "pic1")
//        pencil.size = CGSize(width: 70, height: 150) //ridimensiona l'immagine
//        pencil.position = CGPoint(x: 10, y: 250) //dai una posizione al nodo
//        self.addChild(pencil)
//        pencil.zPosition = 1
//        
//        let pencil2 = SKSpriteNode(imageNamed: "pic2")
//        pencil2.size = CGSize(width: 70, height: 150)
//        pencil2.position = CGPoint(x: 10, y: 250)
//        pencil2.zPosition = 0
//        self.addChild(pencil2)
//        
//        
//        
//        let beeAtlas = SKTextureAtlas(named:"Pencil")
//        
//        let frames :[SKTexture] = [
//               beeAtlas.textureNamed("pic1"),
//               beeAtlas.textureNamed("pic2")]
//        
//        let flyAction = SKAction.animate(with: frames,
//                                         timePerFrame: 0.8)
//    
//        let beeAction = SKAction.repeatForever(flyAction)
//        pencil.run(beeAction)
//        pencil2.run(beeAction)
//        
//        let move = SKAction.moveBy(x: 200, y: 100, duration: 10)
//        pencil.run(move)
//        pencil2.run(move)
//     
//
//
//        
//    }
//}
//
//struct LaunchScreenView: View {
//    var scene: SKScene {
//        let scene = GameScene()
//        scene.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//        return scene
//    }
//    var body: some View {
//        ZStack{
//        LinearGradient(gradient: Gradient(colors: [.black, .white.opacity(0.8), .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
//            SpriteView(scene: scene)
//                .frame(width: 320, height: 650)
//        }
//    }
//}
//
//struct LaunchScreenPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchScreenView()
//    }
//}

        
    
    


//struct LaunchScreenView: View {
//    var scene: SKScene {
//        let scene = GameScene()
//        scene.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//        return scene
//    }
//
//    var body: some View {
//        ZStack{
////            Text("Notability")
////                .fontWeight(.bold)
////                .font(.system(size: 50,weight:.semibold, design: .monospaced))
////                .foregroundStyle(LinearGradient(gradient: Gradient(colors:[Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
//            SpriteView(scene: scene)
//            .frame(width: 320, height: 650)
//        }
//        
//       
//    }
//}
//
//struct LaunchScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchScreenView()
//    }
//}
