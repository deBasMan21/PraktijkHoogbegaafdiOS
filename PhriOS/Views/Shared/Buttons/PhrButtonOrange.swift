//
//  PhrButtonOrange.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

struct OrangeButton: ButtonStyle {
    var disabled : Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18))
            .padding()
            .background(disabled ? .gray : Color(PHR_ORANGE))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
