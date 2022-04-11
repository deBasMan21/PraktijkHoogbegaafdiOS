//
//  HomeView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 50)
            
            Text("Welkom terug in de app! Klik hieronder om je intensiteiten in te vullen. Dit kan tot 3 keer per dag.")
                .padding()
                .multilineTextAlignment(.center)

            
            Spacer()
            
            if !viewModel.adultMode {
                NavigationLink(destination: BillieView(mode: .child), tag: 1, selection: $viewModel.action){
                    PhrButtonOrange(text: "Vul je X-Citabillies in", onClick: {
                        viewModel.action = 1
                    }).padding(.horizontal)
                }
                
                NavigationLink(destination: BillieView(mode: .parent), tag: 2, selection: $viewModel.action){
                    PhrButtonPurple(text: START_INTENSITEITEN_PARENT, onClick: {
                        viewModel.action = 2
                    }).padding()
                }
            } else {
                NavigationLink(destination: BillieView(mode: .adult), tag: 3, selection: $viewModel.action){
                    PhrButtonOrange(text: START_INTENSITEITEN_ADULT, onClick: {
                        viewModel.action = 3
                    }).padding()
                }
            }
            

        }.navigationTitle("Home")
    }
}
