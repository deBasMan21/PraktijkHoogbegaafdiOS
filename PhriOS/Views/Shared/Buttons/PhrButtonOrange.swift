//
//  PhrButtonOrange.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct PhrButtonOrange: View {
    @State var text : String
    @State var onClick : () -> Void
    
    var body: some View {
        Button(action: onClick) {
                Text(text)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2)
                )
            }
            .background(Color(PHR_ORANGE))
            .cornerRadius(25)
    }
}


struct PhrButtonOrangeWithOptions: View {
    @State var text : String
    @State var onClick : () -> Void
    var active : () -> Bool
    
    var body: some View {
        Button(action: onClick) {
                Text(text)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2)
                )
            }
            .background(getColor())
            .cornerRadius(25)
    }
    
    func getColor() -> Color {
        return active() ? Color(PHR_ORANGE) : .gray
    }
}
