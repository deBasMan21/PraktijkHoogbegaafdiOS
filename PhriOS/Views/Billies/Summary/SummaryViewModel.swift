//
//  SummaryViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation
import SwiftUI

extension SummaryView {
    class ViewModel : ObservableObject {
        @Published var mode : BillieMode
        @Published var values : [Billie : Double]
        
        @Published var action : Int? = 0
        
        init(mode : BillieMode, values: [Billie: Double]){
            self.mode = mode
            self.values = values
        }
        
        func saveStats() {
            print("saved")
        }
    }
}
