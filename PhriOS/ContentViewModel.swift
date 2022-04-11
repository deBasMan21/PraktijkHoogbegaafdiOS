//
//  ContentViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation
import SwiftUI

extension ContentView {
    class ViewModel : ObservableObject {
        @Published var selectedMenu : MenuItem = .home
        @Published var isNew = true
        @Published var showNavBar = true
        
        init() {
            let defs = UserDefaults()
            isNew = defs.string(forKey: DEFS_BEGELEIDSTER) == nil
        }
    }
}
