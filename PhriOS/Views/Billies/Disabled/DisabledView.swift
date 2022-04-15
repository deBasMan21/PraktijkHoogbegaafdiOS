//
//  DisabledView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 15/04/2022.
//

import SwiftUI

struct DisabledView : View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.managedObjectContext) var moc
    @State var mode : BillieMode
    
    var body: some View {
        VStack{
            if !viewModel.isValid {
                Image("sterren")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(50)
                    .padding(.horizontal, 100)
                
                Text(BILLIES_MAX_ENTERED)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                Spacer()
            } else {
                BillieView(mode: mode)
            }
        }.onAppear{
            viewModel.canAddData(moc: moc, mode: mode)
        }
    }
}
