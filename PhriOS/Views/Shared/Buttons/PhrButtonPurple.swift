//
//  PhrButtonPurple.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct PhrButtonPurple: View {
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
            .background(Color(PHR_PURPLE))
            .cornerRadius(25)
    }
}


struct PurpleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18))
            .padding()
            .background(Color(PHR_PURPLE))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
