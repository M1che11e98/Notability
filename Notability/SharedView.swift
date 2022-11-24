//
//  SharedView.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 22/11/22.
//

import SwiftUI

struct SharedView: View {
    @ObservedObject var vm: ViewModel
    @State private var isChange: Bool = false
    let backgroundColor: Color = (Color(#colorLiteral(red: 0.949898541, green: 0.9449329972, blue: 0.9665288329, alpha: 1)))
    let backgroundColor2: Color = Color (#colorLiteral(red: 0.9450977445, green: 0.9450984597, blue: 0.9623071551, alpha: 1))
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.white)
                VStack{
                  
                    Image(systemName: "shared.with.you")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .frame(width: 150)
                        .shadow(radius: 10)
                        .padding(.top, 150)
                    Text("There are no shared notes")
                        .font(.title2)
                        .font(.system(.caption))
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    Text("Shared notes will appear here.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                        .padding(.top, 1)
                    Spacer()

                }
     
                
            } .navigationTitle("Shared")
                .padding(.top, 30)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isChange.toggle()
                        } label: {
                            Image(systemName: isChange ? "list.dash" : "square.grid.2x2")
                        }
                    }
                }
            
        }
        
    }
}
struct SharedView_Previews: PreviewProvider {
    static var previews: some View {
        SharedView(vm: ViewModel())
    }
}
