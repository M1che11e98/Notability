//
//  LaunchView.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 22/11/22.
//

import SwiftUI
import SpriteKit


class FirefilesScene: SKScene {

    let snowEmitterNode = SKEmitterNode(fileNamed: "MyParticle")

    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue:
                                        0.95, alpha: 1.0)
        guard let snowEmitterNode = snowEmitterNode else { return }
        snowEmitterNode.particleSize = CGSize(width: 10, height: 30)
        snowEmitterNode.particleLifetime = 10
        snowEmitterNode.particleLifetimeRange = 100
        addChild(snowEmitterNode)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        guard let snowEmitterNode = snowEmitterNode else { return }
        snowEmitterNode.particlePosition = CGPoint(x: size.width/2, y: size.height - 200)
        snowEmitterNode.particlePositionRange = CGVector(dx: size.width, dy: size.height)
    }
}

    

struct LaunchView: View {
    @State var animatedText: String = ""
     @State private var flag = true
     
     var scene: SKScene {
         let scene = FirefilesScene()
         scene.scaleMode = .resizeFill
         scene.backgroundColor = .clear
         return scene
     }
     
    var body: some View {
        ZStack {
            SpriteView(scene: scene, options: [.allowsTransparency])
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            VStack() {
                Spacer()
                Text(animatedText)
                    .font(.system(size: 50))
                    .fontWeight(.light)
                    .animation(.spring())
                    .padding()
                
                //                .font(.system(size: 50,weight:.semibold, design: .monospaced))
                ////                .foregroundStyle(LinearGradient(gradient: Gradient(colors:[Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                //            SpriteView(scene: scene)
                //            .frame(width: 320, height: 650)
                
                
                
                
                
                
            }
        }
        .onAppear{
            animatedText = ""
            "Notability".enumerated().forEach { index, character in
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.2) {
                    animatedText += String(character)
                }
            }
        }
    }
}
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
