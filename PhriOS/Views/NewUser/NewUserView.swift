//
//  NewUserView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import SwiftUI

struct NewUserView: View {
    @StateObject var viewModel = ViewModel()
    @Binding var isNew : Bool
    
    var body: some View {
        VStack{
            ScrollView {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 25)
                
                Text(WELCOME_MESSAGE)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 25)
                
                Spacer()
                
                VStack{
                    Text("Gebruiker(s):")
                    
                    Picker(selection: $viewModel.adultMode, label: Text("view")){
                        Text("Volwassen").tag(true)
                        Text("Ouder met kind").tag(false)
                    }.pickerStyle(.segmented)
                }
                
                VStack{
                    Text("Begeleidster: ")
                    
                    Picker("Selecteer begeleidster", selection: $viewModel.selectedBegeleidster) {
                        ForEach(BEGELEIDSTERS.sorted(by: >), id: \.key) { key, value in
                            Text(key)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }.padding(.vertical, 25)
                
                VStack{
                    Text("Naam:")
                    
                    TextField("Naam", text: $viewModel.name)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.words)
                }
            }
            
            Spacer()
            
            Button(action: save){
                Text("Beginnen")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(OrangeButton(disabled: !viewModel.isValid()))
            
        }.padding(.horizontal, 50)
            .alert(DISCLAIMER_MESSAGE, isPresented: $viewModel.showDisclaimer){
                Button("Doorgaan", action: requestPermission)
            }
            .navigationTitle("Start")
            .navigationBarHidden(true)
    }
    
    func save() {
        if viewModel.isValid() {
            viewModel.saveAndContinue()
            isNew = false
        }
    }
}
