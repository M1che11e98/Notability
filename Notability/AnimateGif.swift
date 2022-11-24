//
//  AnimateGif.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 23/11/22.
//

import SwiftUI
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    
    private var playerAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Paint")
    }
    
    private var playerTexture: SKTexture {
        return playerAtlas.textureNamed("Paint")
    }
    
    private var playerIdleTextures: [SKTexture] = []
    
    
    
    
    // {
//        return [
//
//            playerAtlas.textureNamed("1"),
//            playerAtlas.textureNamed("2"),
//            playerAtlas.textureNamed("3"),
//            playerAtlas.textureNamed("4"),
//            playerAtlas.textureNamed("5"),
//            playerAtlas.textureNamed("6"),
//            playerAtlas.textureNamed("7"),
//            playerAtlas.textureNamed("8"),
//            playerAtlas.textureNamed("9"),
//            playerAtlas.textureNamed("11"),
//        ]
   // }
    
    private func setupPlayer () {
        player = SKSpriteNode(texture: playerTexture, size: CGSize(width: 300, height: 300))
        player.position = CGPoint(x:frame.width/2, y: frame.height/2)
        addChild(player)
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.5692085028, green: 0.9227064252, blue: 0.9264844656, alpha: 1)
        self.setupPlayer()
        self.action()
        
    }
    
    func action() {
        
        for index in 0..<playerAtlas.textureNames.count {
            let textureNames = String(index + 1)
            playerIdleTextures.append(playerAtlas.textureNamed(textureNames))
            
        }
        
        
        let action = SKAction.animate(with: playerIdleTextures, timePerFrame: 0.250)
        
        let paintAction = SKAction.repeatForever(action)
        player.run(paintAction)
        
        player.run(SKAction.repeat(action, count: 1), withKey: ("playerIdleAnimation"))
    }
    
    
    
  }
    
    
    
    
    
    

struct AnimateGif: View {
    @State var animatedText: String = ""
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        return scene
    }
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color(red: 0.5692085028, green: 0.9227064252, blue: 0.9264844656))
                    SpriteView(scene: scene)
                        .frame(width: 320, height: 650)
                        .padding(.bottom, 50)
            VStack{
                
                    Spacer()
                BounceAnimationView(text: "Notability", startTime: 0.0)
                    .padding(.bottom, 10)
//                    Text(animatedText)
//                        .font(.system(size: 50))
//                        .fontWeight(.light)
//                        .animation(.spring())
//                        .padding()
                    
                    //                .font(.system(size: 50,weight:.semibold, design: .monospaced))
                    ////                .foregroundStyle(LinearGradient(gradient: Gradient(colors:[Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    //            SpriteView(scene: scene)
                    //            .frame(width: 320, height: 650)
                    
                    
                    
                    
                    
                    
                }
            }
//            .onAppear{
//                animatedText = ""
//                "Notability".enumerated().forEach { index, character in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.2) {
//                        animatedText += String(character)
//                    }
//                }
//            }
            }
                
    }


struct AnimateGif_Previews: PreviewProvider {
    static var previews: some View {
        AnimateGif()
    }
}
