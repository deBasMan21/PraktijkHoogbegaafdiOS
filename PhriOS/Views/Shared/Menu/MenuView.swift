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
                
                VStack{
                    Image("home").onTapGesture {
                        withAnimation{
                            selectedMenu = .home
                        }
                    }
                    
                    if selectedMenu == .home    {
                        Divider().frame(width: 44)
                    }
                }
                
                Spacer()
                
                VStack{
                    Image("graph").onTapGesture {
                        withAnimation{
                            selectedMenu = .graph
                        }
                    }
                    
                    if selectedMenu == .graph    {
                        Divider().frame(width: 44)
                    }
                }
                
                Spacer()
                
                VStack{
                    Image("settings").onTapGesture {
                        withAnimation{
                            selectedMenu = .settings
                        }
                    }
                    
                    if selectedMenu == .settings    {
                        Divider().frame(width: 44)
                    }
                }
                
                Spacer()
            }.padding()
        }
    }
}
