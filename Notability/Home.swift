//
//  ContentView.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 14/11/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var vm: ViewModel
    init(vm: ViewModel) {
        self.vm = vm
        let apparence = UITabBarAppearance()
        apparence.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = apparence
    }
        
        var body: some View {

            
            TabView{
                NotesGridView(vm: vm)
                    .tabItem {
                        Image(systemName: "rectangle.grid.3x2.fill")
                        Text("Notes")
                    }
                   // .environmentObject(vm)
                SharedView(vm: vm)
              
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("Shared")
                    }
                FavoriteView(vm: vm)
                    .tabItem {
                        Image(systemName: "list.star")
                        Text("Favorites")
                    }
                   // .environmentObject(vm)
                
            }
        }
    }

    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Home(vm: ViewModel())
               // .environmentObject(ViewModel())
        }
    }

    struct FirstView: View {
        var body: some View{
            ZStack{
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea(edges: .top)
                Text("First View")
            }
        }
    }

    struct SecondView: View {
        var body: some View{
            ZStack{
                Color.blue
                    .opacity(0.5)
                    .ignoresSafeArea(edges: .top)
                Text("Second View")
            }
        }
    }

    struct ThirdView: View {
        var body: some View{
            ZStack{
                Color.red
                    .opacity(0.5)
                    .ignoresSafeArea(edges: .top)
                Text("Third View")
            }
        }
        
    }



