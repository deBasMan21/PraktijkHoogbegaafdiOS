//
//  ContentView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: PHR_PURPLE)!]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: PHR_PURPLE)!]
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if viewModel.isNew {
                    NewUserView(isNew : $viewModel.isNew).onAppear{
                        viewModel.selectedMenu = .home
                    }.onAppear{
                        viewModel.showNavBar = false
                    }
                } else {
                    VStack{
                        if viewModel.selectedMenu == .home {
                            HomeView()
                        } else if viewModel.selectedMenu == .graph {
                            GraphView()
                        } else if viewModel.selectedMenu == .settings {
                            SettingsView(isNew: $viewModel.isNew)
                        }
                        
                        Spacer()
                        
                        MenuView(selectedMenu: $viewModel.selectedMenu)
                    }.onAppear{
                        viewModel.showNavBar = true
                    }
                }
            }.navigationBarHidden(!viewModel.showNavBar)
        }
    }
}
