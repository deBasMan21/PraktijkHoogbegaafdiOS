//
//  BillieView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import SwiftUI

struct BillieView: View {
    @State var viewModel : ViewModel
    
    init(mode : BillieMode){
        self.viewModel = ViewModel(mode: mode, billieIndex: 1, values: [:])
    }
    
    var body: some View {
        VStack{
            if viewModel.billieIndex < Billie.allCases.count{
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 100)
                
                Text(viewModel.getTextForEnvironment())
                
                Slider(value: $viewModel.currentValue, in: viewModel.mode.childNames() ? 0...10 : -2...2, step: 1){
                    Text("")
                } minimumValueLabel: {
                    Text(viewModel.mode.childNames() ? "0" : "-2")
                } maximumValueLabel: {
                    Text(viewModel.mode.childNames() ? "10" : "2")
                }
                
                if viewModel.currentValue == 1 {
                    Text("\(viewModel.currentValue)")
                }
                
                Button("Volgende", action: {
                    viewModel.saveValues()
                    viewModel = ViewModel(mode: viewModel.mode, billieIndex: viewModel.billieIndex + 1, values: viewModel.values)
                }).buttonStyle(OrangeButton())
            }

            NavigationLink(destination: SummaryView(mode: viewModel.mode, values: viewModel.values), tag: 4, selection: $viewModel.action){
                
            }
            
        }.navigationBarBackButtonHidden(true)
            .padding(.horizontal, 50)
    }
}
