//
//  HomeViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation
import SwiftUI

extension HomeView {
    class ViewModel : ObservableObject {
        @Published var adultMode  = false
        @Published var action: Int? = 0
        
        let defs = UserDefaults()
        
        init(){
            adultMode = defs.bool(forKey: DEFS_ADULT_MODE)
        }
    }
}
