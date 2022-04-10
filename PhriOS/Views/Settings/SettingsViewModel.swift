//
//  SettingsViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 10/04/2022.
//

import Foundation
import SwiftUI

extension SettingsView {
    class ViewModel : ObservableObject {
        @Published var adultMode : Bool = false
        @Published var begeleidster : String = ""
        
        let defs = UserDefaults()
        
        init(){
            adultMode = defs.bool(forKey: DEFS_ADULT_MODE)
            begeleidster = defs.string(forKey: DEFS_BEGELEIDSTER) ?? BEGELEIDSTERS["Lisanne Boerboom"]!
        }
        
        func saveSettings() {
            defs.set(adultMode, forKey: DEFS_ADULT_MODE)
            defs.set(begeleidster, forKey: DEFS_BEGELEIDSTER)
        }
    }
}
