////
////  NotePreview.swift
////  Notability
////
////  Created by Marta Michelle Caliendo on 21/11/22.
////
//
import SwiftUI

struct NotePreview: View {
    let text: String
    var body: some View {
        ZStack{
            Image("Note2")
                .resizable()
                .scaledToFill()
                .frame(width: 140)
                .shadow(radius: 10)
            Text(text)
                .font(.system(size: 10))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .baselineOffset(3.1)
                .frame(width: 75, height: 93, alignment: .topLeading)
                .lineLimit(8)
        }
    }
}

struct NotePreview_Previews: PreviewProvider {
    static var previews: some View {
        NotePreview(text: "")
    }
}

struct NotePreview2: View {
    let text: String
    var body: some View {
        ZStack{
            Image("Note2")
                .resizable()
                .scaledToFill()
                .frame(width: 90)
                .shadow(radius: 10)
            Text(text)
                .font(.system(size: 9))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .baselineOffset(1.8)
                .frame(width: 55, height: 56, alignment: .topLeading)
                .lineLimit(5)
            
        }
            }
        
    }
    

