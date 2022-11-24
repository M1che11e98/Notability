//
//  ContentView.swift
//  PaintApp
//
//  Created by Marta Michelle Caliendo on 17/11/22.

//Paint project tentativo 1

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 1.0
}

struct Paintview: View {
    
   
    @Binding var lines: [Line] 
    @Binding var thickness: Double
    @Binding var currentLine: Line
    
    var body: some View {

        VStack {
            Canvas { context, size in
                
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
                
                
            }
            .frame(minWidth: 400, minHeight: 400)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({ value in
                let newPoint = value.location
                currentLine.points.append(newPoint)
                self.lines.append(currentLine)
              })
            .onEnded({ value in
                self.lines.append(currentLine)
                self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
            })
            )
            
        }.padding()
    }
}

struct PaintView_Previews: PreviewProvider {
    static var previews: some View {
        Paintview(lines: .constant([]), thickness: .constant(1.0), currentLine: .constant(Line()))
    }
}
