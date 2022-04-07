//
//  HomeView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 50)
                .padding(.top, 50)
            
            Text("Welkom terug in de app! Klik hieronder om je intensiteiten in te vullen. Dit kan tot 3 keer per dag.")
                .padding()
                .multilineTextAlignment(.center)
            
            Spacer()
            
            PhrButtonOrange(text: "Vul je X-Citabillies in", onClick: {
                print("hi")
            }).padding(.horizontal)
            
            PhrButtonPurple(text: "Vul de intensiteiten van je kind in", onClick: {
                print("hi")
            }).padding()
        }
    }
}
