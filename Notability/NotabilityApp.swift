//
//  NotabilityApp.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 14/11/22.
//

import SwiftUI

@main
struct NotabilityApp: App {
    @State private var showHome: Bool = true
    @StateObject private var vm: ViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack{
                if showHome == true {
                    AnimateGif()
                } else {
                    Home(vm: vm)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.4) {
                    withAnimation(.easeInOut(duration: 2)) { //withAnimation non funzione con il DispatchQueue
                        showHome = false
                    }
                }
            }
                //.environmentObject(vm)
        }
    }
}
