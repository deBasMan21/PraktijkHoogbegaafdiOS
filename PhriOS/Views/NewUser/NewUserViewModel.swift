//
//  NewUserViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation
import SwiftUI

extension NewUserView {
    class ViewModel : ObservableObject {
        @Published var selectedBegeleidster = ""
        @Published var adultMode = false
        @Published var name = ""
        
        @Published var showDisclaimer = false
        
        let defs = UserDefaults()
        
        init() {
            selectedBegeleidster = BEGELEIDSTERS.sorted(by: <).first!.key
            showDisclaimer = true
        }
        
        func isValid() -> Bool {
            return selectedBegeleidster != "" && name != ""
        }
        
        func saveAndContinue() {
            if isValid() {
                defs.set(selectedBegeleidster, forKey: DEFS_BEGELEIDSTER)
                defs.set(adultMode, forKey: DEFS_ADULT_MODE)
                defs.set(name, forKey: DEFS_NAME)
            }
        }
    }
}
