//
//  HomeViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation

extension HomeView {
    class ViewModel : ObservableObject {
        @Published var adultMode  = false
        
        let defs = UserDefaults()
        
        init(){
            adultMode = defs.bool(forKey: DEFS_ADULT_MODE)
        }
    }
}
