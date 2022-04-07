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
    @State var on = false
    
    var body: some View {
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
            
            MultiLineChartView(lines: $viewModel.filteredEntries)
                .frame(height: 220)

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
}
