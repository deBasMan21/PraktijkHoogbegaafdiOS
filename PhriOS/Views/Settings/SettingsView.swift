//
//  SettingsView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 10/04/2022.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = ViewModel()
    @Binding var isNew : Bool
    

    
    var body: some View {
        VStack{
            VStack{
                Text("Je begeleidster: ")
                
                Picker("Selecteer begeleidster", selection: $viewModel.begeleidster) {
                    ForEach(BEGELEIDSTERS.sorted(by: <), id: \.key) { key, value in
                        Text(key)
                    }
                }.onChange(of: viewModel.begeleidster) {tag in
                    viewModel.saveSettings()
                }.pickerStyle(MenuPickerStyle())
            }
            VStack{
                Text("Je naam:")
                
                TextField("Naam", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.words)
                    .onChange(of: viewModel.name, perform: { tag in
                        viewModel.saveSettings()
                    })
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(PHR_ORANGE))
            }.padding(.vertical, 25)

            Spacer()
            
            Toggle("Volwassen mode", isOn: $viewModel.adultMode)
                .onChange(of: viewModel.adultMode){ value in
                    viewModel.saveSettings()
                }.tint(Color(PHR_ORANGE))
            
            Text("Versie \(VERSION)").onTapGesture{
                viewModel.counter += 1
                if viewModel.counter > 4 {
                    viewModel.counter = 0
                    viewModel.showResetAlert = true
                }
            }
        }.navigationTitle("Instellingen")
            .padding(.horizontal, 50)
            .alert(RESET_MESSAGE, isPresented: $viewModel.showResetAlert){
                Button("Doorgaan", role: .destructive, action: {
                    viewModel.reset()
                    isNew = true
                })
            }

    }
}
