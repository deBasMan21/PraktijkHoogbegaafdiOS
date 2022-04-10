//
//  GraphView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI
import Charts
 
struct GraphChildView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            ScrollView{
                Picker(selection: $viewModel.showChild, label: Text("view")){
                    Text("Kind").tag(true)
                    Text("Ouder").tag(false)
                }.pickerStyle(.segmented)
                    .onChange(of: viewModel.showChild) {tag in
                        viewModel.loadData()
                    }
                    .padding()
                
                VStack{
                    graphView
                    
                    HStack{
                        Text("Categorie:")
                            .padding(.horizontal)
                        
                        Picker("Selecteer categorie", selection: $viewModel.selectedGraph) {
                            ForEach(Billie.allCases, id: \.self) {
                                Text($0.description)
                            }
                        }.onChange(of: viewModel.selectedGraph) {tag in
                            viewModel.filter()
                        }.pickerStyle(MenuPickerStyle())
                    }

                    VStack{
                        DatePicker("Begin moment", selection: $viewModel.beginDate, in: ...viewModel.beginDate, displayedComponents: [.date])
                        
                        DatePicker("Eind moment", selection: $viewModel.endDate, in: ...Date.now, displayedComponents: [.date])
                    }.padding(.horizontal, 50)
                        .padding(.bottom)
                
                    HStack{
                        VStack{
                            ForEach(Billie.allCases, id: \.self) {
                                if $0 != .All{
                                    Text($0.description + ":")
                                }
                            }
                        }
                        
                        VStack{
                            ForEach(Billie.allCases, id: \.self) {
                                if $0 != .All{
                                    Text(String(viewModel.weekStats[$0] ?? 0.0))
                                        .foregroundColor(Color("PhrOrange"))
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .padding(.trailing, 50)
                        
                        VStack{
                            ForEach(Billie.allCases, id: \.self) {
                                if $0 != .All{
                                    Text($0.description + ":")
                                }
                            }

                        }
                        
                        VStack{
                            ForEach(Billie.allCases, id: \.self) {
                                if $0 != .All{
                                    Text(String(viewModel.dayStats[$0] ?? 0.0))
                                        .foregroundColor(Color("PhrOrange"))
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            PhrButtonOrange(text: "Delen", onClick: {
                viewModel.showShareOptions = true
            }).padding(.horizontal, 50)
            
        }.sheet(isPresented: $viewModel.showMail) {
            MailView(data: $viewModel.mailData){ result in
                print(result)
            }
        }.alert("Kies hieronder wat je wilt delen met je begeleider", isPresented: $viewModel.showShareOptions){
            Button("Alleen ouder", action: {
                Task{
                    await viewModel.share(shareOptions: .parentOnly)
                }
            })
            Button("Alleen kind", action: {
                Task{
                    await viewModel.share(shareOptions: .childOnly)
                }
            })
            Button("Beide",  action: {
                Task{
                    await viewModel.share(shareOptions: .both)
                }
            }).keyboardShortcut(.defaultAction)
            Button("Annuleren", role: .cancel, action: {})
        }
    }
    
    var graphView : some View {
        GeometryReader{ geo in
            VStack{
                if viewModel.showChild {
                    MultiLineChartView(lines: $viewModel.filteredEntries, style: ChartStyle(minX: 1.0, maxX: 7.0, minY: 1.0, maxY: 10.0))
                        .frame(height: 220)
                } else {
                    MultiLineChartView(lines: $viewModel.filteredEntries, style: ChartStyle(minX: 1.0, maxX: 7.0, minY: -2.5, maxY: 2.5))
                        .frame(height: 220)
                }
            }.onAppear{
                viewModel.geo = geo
            }
        }.frame(height: 220)
    }
}
