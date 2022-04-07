//
//  MenuView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack{
            Divider()
            
            HStack{
                Spacer()
                
                Image("home")
                
                Spacer()
                
                Image("graph")
                
                Spacer()
                
                Image("settings")
                
                Spacer()
            }.padding()
        }
    }
}
