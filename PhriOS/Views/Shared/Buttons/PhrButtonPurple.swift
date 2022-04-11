//
//  PhrButtonPurple.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI

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
