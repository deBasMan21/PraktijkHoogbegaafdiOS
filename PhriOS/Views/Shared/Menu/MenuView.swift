//
//  MenuView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct MenuView: View {
    @Binding var selectedMenu : MenuItem
    
    var body: some View {
        VStack{
            Divider()
            
            HStack{
                Spacer()
                
                Image("home").onTapGesture {
                    selectedMenu = .home
                }
                
                Spacer()
                
                Image("graph").onTapGesture {
                    selectedMenu = .graph
                }
                
                Spacer()
                
                Image("settings").onTapGesture {
                    selectedMenu = .settings
                }
                
                Spacer()
            }.padding()
        }
    }
}
