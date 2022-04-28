//
//  NewUserView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import SwiftUI
import ConcentricOnboarding

struct NewUserView: View {
    @StateObject var viewModel = ViewModel()
    @Binding var isNew : Bool
    @Binding var showOnboarding: Bool
    
    var body: some View {
        VStack{
            ScrollView {
                VStack{
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 25)
                    
                    Text(WELCOME_MESSAGE)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 25)
                    
                    Spacer()
                    
                    VStack{
                        Text("Gebruik je deze app in het kader van de behandeling bij Praktijk Hoogbegaafd?")
                        
                        Picker(selection: $viewModel.withPhr, label: Text("view")){
                            Text("Ja").tag(true)
                            Text("Nee").tag(false)
                        }.pickerStyle(.segmented)
                            .onChange(of: viewModel.withPhr, perform: {tag in
                                viewModel.isCorrectCode = false
                                viewModel.code = ""
                            })
                    }.alert("Verkeerde code", isPresented: $viewModel.showWrongCode){
                        Button("Oke", action:{})
                    }
                    
                    if viewModel.withPhr && !viewModel.isCorrectCode {
                        VStack{
                            Text("Ontvangen code:")
                            
                            HStack{
                                SecureField("Code", text: $viewModel.code)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.trailing)
                                
                                Button("Verder", action: {
                                    if viewModel.code == "0165" {
                                        viewModel.isCorrectCode = true
                                        viewModel.code = ""
                                    } else {
                                        viewModel.showWrongCode = true
                                        viewModel.isCorrectCode = false
                                        viewModel.code = ""
                                    }
                                }).buttonStyle(PurpleButton())
                            }
                        }.padding()
                    }
                    
                    if !viewModel.withPhr || viewModel.isCorrectCode {
                        VStack{
                            Text("Gebruiker(s):")
                            
                            Picker(selection: $viewModel.adultMode, label: Text("view")){
                                Text("Volwassen").tag(true)
                                Text("Ouder met kind").tag(false)
                            }.pickerStyle(.segmented)
                        }.padding()
                        
                        VStack{
                            Text("Naam:")
                            
                            TextField("Naam", text: $viewModel.name)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.words)
                        }
                        
                        if viewModel.isCorrectCode {
                            VStack{
                                Text("Kies behandelaar: ")
                                
                                Menu{
                                    Picker("Selecteer begeleidster", selection: $viewModel.selectedBegeleidster) {
                                        ForEach(BEGELEIDSTERS.sorted(by: >), id: \.key) { key, value in
                                            Text(key)
                                        }
                                    }
                                } label: {
                                    Text(viewModel.selectedBegeleidster)
                                        .bold()
                                }
                            }.padding(.vertical, 25)
                        }
                    }
                }.padding(.horizontal, 50)
            }
            
            Spacer()
            
            Button(action: save){
                Text("Beginnen")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(OrangeButton(disabled: !viewModel.isValid()))
                .padding(.horizontal, 50)
            
        }
            .alert(DISCLAIMER_MESSAGE, isPresented: $viewModel.showDisclaimer){
                Button("Doorgaan", action: requestPermission)
            }
            .navigationTitle("Start")
            .navigationBarHidden(true)
    }
    
    func save() {
        if viewModel.isValid() {
            viewModel.saveAndContinue()
            withAnimation{
                showOnboarding = true
                isNew = false
            }
        }
    }
}



