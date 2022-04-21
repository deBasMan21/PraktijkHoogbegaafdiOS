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
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    Divider().padding()
                    
                    if viewModel.withPhr {
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
                    }.padding(.vertical)
                    
                    Divider().padding()
                    
                    VStack{
                        Toggle(isOn: $viewModel.notificationsEnabled){
                            Text("Notificaties ontvangen:")
                                .foregroundColor(Color(PHR_PURPLE))
                                .bold()
                        }.tint(Color(PHR_ORANGE))
                            .onChange(of: viewModel.notificationsEnabled, perform: {value in
                                viewModel.saveSettings()
                                viewModel.switchNotificationsEnabled()
                            })
                        
                        ForEach(0...viewModel.notifications.count - 1, id: \.self) { value in
                            Text("Melding \(value + 1)")
                                .foregroundColor(Color(PHR_ORANGE))
                                .bold()
                            
                            DatePicker("Geselecteerde tijd:", selection: $viewModel.notifications[value], displayedComponents: [.hourAndMinute])
                        }.onChange(of: viewModel.notifications, perform: { value in
                            viewModel.saveSettings()
                            viewModel.saveNotifications()
                        })
                    }
                    
                    Divider().padding()
                    
                    Toggle("Volwassen mode", isOn: $viewModel.adultMode)
                        .onChange(of: viewModel.adultMode){ value in
                            viewModel.saveSettings()
                        }.tint(Color(PHR_ORANGE))
                }.padding(.horizontal, 50)
            }.alert("Let op! Hiervoor moet je toestemming gegeven hebben. Dit kan later nog gedaan worden in de instellingen van je telefoon.", isPresented: $viewModel.notificationsError){
                Button("Oke", role: .cancel, action:{})
            }
            
            Spacer()

            Text("Versie \(VERSION)").onTapGesture{
                viewModel.counter += 1
                if viewModel.counter > 4 {
                    viewModel.counter = 0
                    viewModel.showResetAlert = true
                }
            }
        }.navigationTitle("Instellingen")
            .alert(RESET_MESSAGE, isPresented: $viewModel.showResetAlert){
                Button("Doorgaan", role: .destructive, action: {
                    viewModel.reset(moc: moc)
                    isNew = true
                })
            }
    }
}
