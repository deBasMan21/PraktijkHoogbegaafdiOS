//
//  BillieView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import SwiftUI

struct BillieView: View {
    @State var viewModel : ViewModel
    @State var value : Double
    
    init(mode : BillieMode){
        self.viewModel = ViewModel(mode: mode, billieIndex: 1, values: [:])
        value = mode.childNames() ? 5.0 : 0.0
    }
    
    var body: some View {
        VStack{
            if viewModel.billieIndex < Billie.allCases.count{
                Spacer()
                
                VStack{
                    Image("sterren").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    
                    Text(viewModel.getTextForEnvironment())
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(PHR_PURPLE))
                        
                    
                    Slider(value: $value, in: viewModel.mode.childNames() ? 0...10 : -2...2, step: 1){
                        Text("\(value)")
                    } minimumValueLabel: {
                        Text(viewModel.mode.childNames() ? "0" : "-2")
                    } maximumValueLabel: {
                        Text(viewModel.mode.childNames() ? "10" : "2")
                    }
                    
                    Text("\(String(format: "%.0f", value))")
                        .foregroundColor(Color(PHR_ORANGE))
                        .bold()
                    
                    Button(action: {
                        viewModel.currentValue = value
                        viewModel.saveValues()
                        viewModel = ViewModel(mode: viewModel.mode, billieIndex: viewModel.billieIndex + 1, values: viewModel.values)
                    }){
                        Text("Volgende")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(PurpleButton())
                        .padding()
                    
                }.padding(.horizontal, 50)
                
                Spacer()
                
                if viewModel.mode == .child {
                    Image("\(viewModel.currentBillie.description)-tekst")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text(BILLIES_DESCRIPTION[viewModel.currentBillie]!)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.gray)
                        .frame(height: 300)
                }
            }

            NavigationLink(destination: SummaryView(mode: viewModel.mode, values: viewModel.values), tag: 4, selection: $viewModel.action){
                
            }
            
        }.navigationBarBackButtonHidden(true)
            
    }
}
