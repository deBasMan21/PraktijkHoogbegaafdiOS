//
//  GraphView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI
import Charts

struct GraphView: View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ScrollViewReader { scroll in
            VStack{
                ScrollView{
                    if !viewModel.adultMode{
                        Picker(selection: $viewModel.showChild, label: Text("view")){
                            Text("Kind").tag(true)
                            Text("Ouder").tag(false)
                        }.pickerStyle(.segmented)
                            .onChange(of: viewModel.showChild) {tag in
                                viewModel.loadData()
                            }
                            .padding()
                    }
                    
                    VStack{
                        graphView
                        
                        HStack{
                            Text("Categorie:")
                                .padding(.horizontal)
                            
                            Menu{
                                Picker("Selecteer categorie", selection: $viewModel.selectedGraph) {
                                    ForEach(Billie.allCases, id: \.self) {
                                        Text($0.toString(child: viewModel.showChild))
                                    }
                                }.onChange(of: viewModel.selectedGraph) {tag in
                                    viewModel.filter()
                                }
                            } label: {
                                Text(viewModel.selectedGraph.toString(child: viewModel.showChild))
                                    .bold()
                            }
                        }
                        
                        DatePicker("Geselecteerde datum:", selection: $viewModel.endDate, in: ...Date.now, displayedComponents: [.date])
                            .onChange(of: viewModel.endDate, perform: { tag in
                                viewModel.loadData()
                            }).padding(.horizontal, 50)
                            .padding(.bottom)
                        
                        
                        VStack{
                            Text("Periodegemiddelde van \n\(viewModel.endDate.addingTimeInterval(60 * 60 * 24 * -7).toString()) t/m \(viewModel.endDate.toString()):")
                                .foregroundColor(Color(PHR_PURPLE))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 50){
                                VStack(alignment: .leading){
                                    ForEach(Billie.allCases, id: \.self) {
                                        if $0 != .All{
                                            Text($0.toString(child: viewModel.showChild) + ":")
                                        }
                                    }
                                }
                                
                                VStack(alignment: .trailing){
                                    ForEach(Billie.allCases, id: \.self) {
                                        if $0 != .All{
                                            Text(String(viewModel.weekStats[$0] ?? 0.0))
                                                .foregroundColor(Color(PHR_ORANGE))
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom)
                        
                        VStack{
                            Text("Daggemiddelde van \(viewModel.endDate.toString()):")
                                .foregroundColor(Color(PHR_PURPLE))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 50){
                                VStack(alignment: .leading){
                                    ForEach(Billie.allCases, id: \.self) {
                                        if $0 != .All{
                                            Text($0.toString(child: viewModel.showChild) + ":")
                                        }
                                    }
                                    
                                }
                                
                                VStack(alignment: .trailing){
                                    ForEach(Billie.allCases, id: \.self) {
                                        if $0 != .All{
                                            Text(String(viewModel.dayStats[$0] ?? 0.0))
                                                .foregroundColor(Color(PHR_ORANGE))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }.alert(SHARE_STRING_WITH_PHR_OPTIONS, isPresented: $viewModel.showShareWithPhrOptions){
                Button("Via apple mail", action: {
                    Task{
                        await viewModel.choseShareOptions(mail: true)
                    }
                })
                Button("Via deelmenu", action: {
                    Task{
                        await viewModel.choseShareOptions(mail: false)
                    }
                })
                
                Button("Annuleren", role: .cancel, action: {})
            }
            
            Spacer()
            
            Button(action: {
                withAnimation{
                    scroll.scrollTo(1, anchor: .center)
                }
                viewModel.showShareOptions = true
            }){
                Text(viewModel.withPhr ? "Delen" : "Opslaan")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(OrangeButton())
                .padding(.horizontal, 50)
            
        }.sheet(isPresented: $viewModel.showMail) {
            MailView(data: $viewModel.mailData){ result in
                print(result)
            }
        }.alert(viewModel.getShareString(), isPresented: $viewModel.showShareOptions){
            if !viewModel.adultMode {
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
            } else {
                Button("Delen",  action: {
                    Task{
                        await viewModel.share(shareOptions: .parentOnly)
                    }
                }).keyboardShortcut(.defaultAction)
            }
            
            Button("Annuleren", role: .cancel, action: {})
        }.navigationTitle("Grafieken")
            .onAppear{
                viewModel.moc = moc
                viewModel.loadData()
            }
    }
    
    var graphView : some View {
        GeometryReader{ geo in
            VStack{
                if viewModel.showChild {
                    MultiLineChartView(lines: $viewModel.filteredEntries, style: ChartStyle(minX: 1.0, maxX: 7.0, minY: 0.0, maxY: 10.0), child: viewModel.showChild)
                        .frame(height: 220)
                        .id(viewModel.graphId)
                } else {
                    MultiLineChartView(lines: $viewModel.filteredEntries, style: ChartStyle(minX: 1.0, maxX: 7.0, minY: -2.5, maxY: 2.5), child: viewModel.showChild)
                        .frame(height: 220)
                        .id(viewModel.graphId)
                }
            }.id(1)
                .onAppear{
                    viewModel.geo = geo
                }
        }.frame(height: 220)
    }
}
