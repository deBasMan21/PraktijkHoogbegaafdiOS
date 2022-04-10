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
            if isNew() {
                Text("New")
            } else {
                if selectedMenu == .home {
                    HomeView()
                } else if selectedMenu == .graph {
                    GraphView()
                } else if selectedMenu == .settings {
                    SettingsView()
                }
                
                Spacer()
                
                MenuView(selectedMenu: $selectedMenu)
            }
        }
    }
    
    func isNew() -> Bool {
        let defs = UserDefaults()
        return defs.string(forKey: DEFS_BEGELEIDSTER) == nil
    }
}
