//
//  GraphView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 07/04/2022.
//

import SwiftUI

struct GraphView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            ScrollView{
                Picker(selection: $viewModel.showParent, label: Text("view")){
                    Text("Kind").tag(true)
                    Text("Ouder").tag(false)
                }.pickerStyle(.segmented)
                    .padding()
                
                if viewModel.showParent {
                    
                } else {
                    GraphAdultView()
                }
            }
            
            Spacer()
            
            PhrButtonOrange(text: "Delen", onClick: {
                print("hi")
            }).padding(.horizontal, 50)
        }
    }
}
