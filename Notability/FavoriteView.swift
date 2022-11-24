//
//  FavoriteView.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 19/11/22.
//


import SwiftUI

struct FavoriteView: View {
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
                            
                            ForEach(vm.favoriteNotes) { entity in
                                NavigationLink {
                                    ScriptView(vm: vm, note: entity)
                                } label: {
                                    ZStack{
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
              ForEach(vm.favoriteNotes) { entity in
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
                                            .baselineOffset(1.8)
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
            
            .navigationTitle("Favorites")
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

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(vm: ViewModel())
        // .environmentObject(ViewModel())
    }
}

