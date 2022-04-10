//
//  SettingsView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 10/04/2022.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Je begeleidster: ")
                    
                    Picker("Selecteer begeleidster", selection: $viewModel.begeleidster) {
                        ForEach(BEGELEIDSTERS.sorted(by: <), id: \.key) { key, value in
                            Text(key)
                        }
                    }.onChange(of: viewModel.begeleidster) {tag in
                        viewModel.saveSettings()
                    }.pickerStyle(MenuPickerStyle())
                }

                Spacer()
                
                Toggle("Volwassen mode", isOn: $viewModel.adultMode)
                    .onChange(of: viewModel.adultMode){ value in
                        viewModel.saveSettings()
                }.padding(.horizontal, 50)
                
                Text("Versie \(VERSION)")
            }.navigationTitle("Instellingen")
        }

    }
}
