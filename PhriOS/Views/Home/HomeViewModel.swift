//
//  HomeViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation

extension HomeView {
    class ViewModel : ObservableObject {
        @Published var name : String
        
        init(){
            name = "hallo"
        }
    }
}
