//
//  ContentView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMenu : MenuItem = .home
    
    var body: some View {
        VStack{
            if selectedMenu == .home {
                HomeView()
            } else if selectedMenu == .graph {
                GraphView()
            } else if selectedMenu == .settings {
                Text("Settings not yet")
            }
            
            Spacer()
            
            MenuView(selectedMenu: $selectedMenu)
        }
    }
}
