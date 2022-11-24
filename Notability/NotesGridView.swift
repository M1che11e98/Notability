//
//  NotesView.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 15/11/22.
//

import SwiftUI

struct NotesGridView: View {
    @ObservedObject var vm: ViewModel
    @State private var isChange: Bool = false
    @State private var backgroundColor = Color.red
    @State var showView: Bool = false
    
    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: nil, alignment: nil),
        GridItem(.flexible(),spacing: nil, alignment: nil),
        GridItem(.flexible(),spacing: nil, alignment: nil)
    ]
    
    
    var body: some View {
        
        NavigationStack{
                VStack{
                    if !isChange {
                        ScrollView{
                            LazyVGrid(columns: columns, alignment: .center, spacing: 35) {
                                NavigationLink {
                                    ScriptView(vm: vm)
                                    
                                } label: {
                                    AddNote()
                                    //   .environmentObject(vm)
                                }.buttonStyle(.plain)
                                
                                ForEach(vm.savedEntity) { entity in
                                    NavigationLink {
                                        ScriptView(vm: vm, note: entity)
                                    } label: {
                                        ZStack{
    //                                        RoundedRectangle(cornerRadius: 8)
    //                                            .fill(
    //                                                LinearGradient(colors: [Color("Color2"), Color("Color3").opacity(0.7), Color( "Color1")], startPoint: .topLeading, endPoint: .bottomTrailing))
    //
    //                                            .frame(width: 100, height: 110)
    //                                            .shadow(radius: 5)
                                            Image("Note2")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 140)
                                                .shadow(radius: 10)
                                                .overlay {
                                                    Image(systemName: "star.fill")
                                                        .renderingMode(.original)
                                                        .opacity(entity.isFavorite ? 1.0 : 0.0)
                                                        .padding(.leading, 66)
                                                        .padding(.top, 75)
                                                }
                                            Text(entity.text?.string ?? "")
                                                .font(.system(size: 10))
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                                .baselineOffset(2.8)
                                                .frame(width: 75, height: 91, alignment: .topLeading)
                                                .lineLimit(8)
                                            
                                            
                                        }
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    //                                    if let data = entity.image {
                                    //                                        if let uiImage = UIImage(data: data) {
                                    //                                            if let image = Image(uiImage: uiImage) {
                                    //                                                image
                                    //                                                    .resizable()
                                    //                                                    .scaledToFill()
                                    //                                                    .frame(width: 85, height: 98)
                                    //                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    //
                                    //                                            }
                                    //
                                    //                                        } else {
                                    //                                            RoundedRectangle(cornerRadius: 8)
                                    //                                                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .butt, dash:[10]))
                                    //                                                .frame(width: 70, height: 90)
                                    //                                                .overlay {
                                    //                                                    Image(systemName: "heart.fill")
                                    //                                                        .opacity(entity.isFavorite ? 1.0 : 0.0)
                                    //
                                    //                                                }
                                    //
                                    //
                                    //
                                    //                                        }
                                    //
                                    //
                                    //                                    }
                                    
                                    
                                    
                                    
                                    //                                    if let data = entity.image {
                                    //                                        if let uiImage = UIImage(data: data) {
                                    //                                            if let image = Image(uiImage: uiImage) {
                                    //                                                image
                                    //                                                    .resizable()
                                    //                                                    .scaledToFit()
                                    //                                                    .frame(width: 80, height: 100)
                                    
                                    //   }
                                    
                                    //                        } else {
                                    //                                        RoundedRectangle(cornerRadius: 8)
                                    //                                                                                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .butt, dash:[10]))
                                    //                                                                                .frame(width: 80, height: 100)
                                    //                                    }
                                    
                                    
                                    //  }
                                    .contextMenu(menuItems: {
                                        Button("Add favorite") {
                                            vm.addFavorite(entity: entity)
                                        }
                                        Button("Share") {
                                            vm.addFavorite(entity: entity)
                                        }
                                        
                                        Button("Delete") {
                                            vm.deleteGridNote(entity: entity)
                                        }
                                        
                                    }, preview: {
                                        NotePreview(text: entity.text?.string ?? "")
                                    })
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    } else {
                        List {
                            NavigationLink {
                                ScriptView(vm: vm)
                            } label: {
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .butt, dash:[10]))
                                            .foregroundColor(.accentColor)
                                            .frame(width: 75, height: 75)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                        Image(systemName: "plus")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.accentColor)
                                            .frame(width: 30)
                                        
                                    } .padding(.leading, 8)
                                    Text("New...")
                                        .foregroundColor(.accentColor)
                                        .padding(.leading, 20)
                                }
                                
                            }
                            
                            
                            ForEach(vm.savedEntity) { entity in
                                NavigationLink {
                                    ScriptView(vm: vm, note: entity)
                                    
                                } label: {
                                    HStack{
                                        ZStack{
                                            Image("Note2")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 90)
                                                .shadow(radius: 6)
                                            Text(entity.text?.string ?? "")
                                                .font(.system(size: 9))
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                                .baselineOffset(1.7)
                                                .frame(width: 55, height: 60, alignment: .topLeading)
                                                .lineLimit(5)
                                            
                                        }
                                        //                                    if let data = entity.image {
                                        //                                        if let uiImage = UIImage(data: data) {
                                        //                                            if let image = Image(uiImage: uiImage) {
                                        //                                                image
                                        //                                                    .resizable()
                                        //                                                    .scaledToFill()
                                        //                                                    .frame(width: 85, height: 85)
                                        //                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                        //
                                        //
                                        //                                            }
                                        //
                                        //                                        }
                                        //                                    } else {
                                        //                                        ImageView()
                                        ////                                        Text(entity.text?.string ?? "")
                                        ////                                            .frame(width: 300, height: 80)
                                        //                                    }
                                        
                                        Text(entity.text?.string ?? "")
                                            .font(.system(size: 15))
                                            .frame(width: 150, height: 80, alignment: .leading)
                                            .lineLimit(1)
                                            .padding(.leading, 10)
                                            .overlay {
                                                Image(systemName: "star.fill")
                                                    .renderingMode(.original)
                                                    .opacity(entity.isFavorite ? 1.0 : 0.0)
                                                    .padding(.leading, 220)
                                            }
                                            .contextMenu(menuItems: {
                                                Button("Add favorite") {
                                                    vm.addFavorite(entity: entity)
                                                }
                                                
                                                Button("Delete") {
                                                    vm.deleteGridNote(entity: entity)
                                                }
                                            }, preview: {
                                                NotePreview(text: entity.text?.string ?? "")
                                            })
                                        
                                    }
                                    
                                }
                                
                            }
                            .onDelete(perform: vm.deleteNote)
                        }
                    }
                }
                
                .navigationTitle("Notes")
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


struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesGridView(vm: ViewModel())
          //  .environmentObject(ViewModel())
    }
}
