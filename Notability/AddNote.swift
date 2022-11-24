//
//  Notes.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 14/11/22.
//

import SwiftUI

struct AddNote: View {
    var body: some View {
      
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .butt, dash:[10]))
                    .foregroundColor(.accentColor)
                    .frame(width: 100, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                addButton
                    
            }
             
        }
       
    }

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
extension AddNote {
    private var addButton: some View {
//        Button{
//
//        }
//    label: {
            Image(systemName: "plus")
            .resizable()
            .scaledToFit()
            .foregroundColor(.accentColor)
            .frame(width: 30)
        
         }
    }

