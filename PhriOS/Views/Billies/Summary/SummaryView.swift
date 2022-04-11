//
//  SummaryView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import SwiftUI

struct SummaryView: View {
    @State var viewModel : ViewModel
    
    init(mode : BillieMode, values : [Billie : Double]){
        self.viewModel = ViewModel(mode: mode, values: values)
    }
    
    var body: some View {
        VStack{
            Divider().padding()
            
            ForEach(viewModel.values.sorted(by: <), id: \.key){ pair in
                if viewModel.mode == .child {
                    HStack{
                        Image("Logo").resizable().aspectRatio(contentMode: .fit).frame(width: 60)
                        
                        Spacer()
                        
                        Text("\(pair.key.toString(child: viewModel.mode.childNames()))")
                        
                        Spacer()
                        
                        Text("\(Int(pair.value))")
                            .foregroundColor(Color(PHR_ORANGE))
                            .bold()
                    }
                    
                    Divider().padding()
                } else {
                    VStack{
                        Text("\(pair.key.toString(child: viewModel.mode.childNames()))")
                        
                        Text("\(Int(pair.value))")
                            .foregroundColor(Color(PHR_ORANGE))
                            .bold()
                        
                        Divider().padding()
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                NavigationUtil.popToRootView()
            }){
                Text("Annuleren")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(PurpleButton())

            Button(action: {
                viewModel.saveStats()
                NavigationUtil.popToRootView()
            }){
                Text("Klaar")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(OrangeButton())
                
        }.navigationBarBackButtonHidden(true)
            .navigationTitle("Samenvatting")
            .padding(.horizontal, 50)
    }
}



