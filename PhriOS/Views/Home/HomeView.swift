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
    @Environment(\.managedObjectContext) var moc
    
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
                NavigationLink(destination: DisabledView(mode: .child), tag: 1, selection: $viewModel.action){
                    Button(action: {
                        viewModel.action = 1
                    }){
                        Text("Vul je X-Citabillies in")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(OrangeButton())
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: DisabledView(mode: .parent), tag: 2, selection: $viewModel.action){
                    Button(action: {
                        viewModel.action = 2
                    }){
                        Text(START_INTENSITEITEN_PARENT)
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(PurpleButton())
                        .padding()
                }
            } else {
                NavigationLink(destination: DisabledView(mode: .adult), tag: 3, selection: $viewModel.action){
                    Button(action: {
                        viewModel.action = 3
                    }){
                        Text(START_INTENSITEITEN_ADULT)
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(OrangeButton())
                    .padding()
                }
            }
            

        }.navigationTitle("Home")
    }
}


