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
        @Published var withPhr = false
        @Published var selectedBegeleidster = ""
        @Published var adultMode = false
        @Published var name = ""
        
        @Published var isCorrectCode = false
        @Published var code = ""
        
        @Published var showDisclaimer = false
        @Published var showWrongCode = false
        @Published var activeLink : Int? = 0
        @Published var hasConsent = false {
            didSet {
                let defs = UserDefaults.standard
                defs.set(hasConsent, forKey: DEFS_SHOW_CONSENT)
            }
        }
        
        let defs = UserDefaults()
        
        init() {
            
            selectedBegeleidster = BEGELEIDSTERS.sorted(by: <).first!.key
            showDisclaimer = true
            
            let defs = UserDefaults.standard
            hasConsent = defs.bool(forKey: DEFS_SHOW_CONSENT)
        }
        
        func isValid() -> Bool {
            return selectedBegeleidster != "" && name != ""
        }
        
        func saveAndContinue() {
            if isValid() {
                defs.set(selectedBegeleidster, forKey: DEFS_BEGELEIDSTER)
                defs.set(adultMode, forKey: DEFS_ADULT_MODE)
                defs.set(name, forKey: DEFS_NAME)
                defs.set(withPhr, forKey: DEFS_WITH_PHR)
                defs.set([Date().timeFromComponents(hour: 10, minute: 00)!, Date().timeFromComponents(hour: 16, minute: 00)!, Date().timeFromComponents(hour: 20, minute: 00)!], forKey: DEFS_NOTIFICATIONS)
            }
        }
    }
}
