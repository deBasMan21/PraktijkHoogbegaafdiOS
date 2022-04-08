//
//  GraphView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI
import Charts
 
struct GraphAdultView: View {
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
                    
                    graphView

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
                
                ForEach(viewModel.images, id: \.self){
                    Image(uiImage: $0).resizable().aspectRatio(contentMode: .fit).padding(.horizontal, 50)
                }
            }
            
            Spacer()
            
            PhrButtonOrange(text: "Delen", onClick: {
                    Task{
                        await viewModel.switchBot()
                    }
            }).padding(.horizontal, 50)
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
        }.frame(width: 400, height: 220)
    }
}
