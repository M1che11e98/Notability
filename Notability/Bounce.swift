//
//  Bounce.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 24/11/22.
//

import SwiftUI

struct Bounce: View {
    var body: some View {
        VStack {
            
            BounceAnimationView(text: "Notability", startTime: 0.0)

        }
    }
}
//Text animate
struct BounceAnimationView: View {
    let characters: Array<String.Element>
    
    @State var offsetYForBounce: CGFloat = -50
    @State var opacity: CGFloat = 0
    @State var baseTime: Double
    
    init(text: String, startTime: Double){
        self.characters = Array(text)
        self.baseTime = startTime
    }
    
    var body: some View {
        HStack(spacing:0){
            ForEach(0..<characters.count) { num in
                Text(String(self.characters[num]))
                    .font(.system(size: 50))
                    .tracking(5)
                    .fontWeight(.light)
                                          
                    .offset(x: 0.0, y: offsetYForBounce)
                    .opacity(opacity)
                    .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.1).delay( Double(num) * 0.1 ), value: offsetYForBounce)
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    opacity = 0
                    offsetYForBounce = -50 }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    opacity = 1
                    offsetYForBounce = 0
                }
                
                
            }
        }
        
    }
                
}


struct Bounce_Previews: PreviewProvider {
    static var previews: some View {
        Bounce()
    }
}

