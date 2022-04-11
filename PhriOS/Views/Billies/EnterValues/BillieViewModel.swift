//
//  BillieViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation
import SwiftUI

extension BillieView {
    class ViewModel : ObservableObject {
        @Published var mode : BillieMode
        @Published var billieIndex : Int
        @Published var currentBillie : Billie
        
        @Published var currentValue : Double
        @Published var isEditing = false
        
        @Published var values : [Billie : Double]
        @Published var action : Int? = 0
        let defs = UserDefaults()
        
        init(mode : BillieMode, billieIndex : Int, values: [Billie : Double]){
            self.billieIndex = billieIndex
            self.mode = mode
            self.values = values
            
            if billieIndex < Billie.allCases.count {
                self.currentBillie = Billie.allCases[billieIndex]
            } else {
                self.currentBillie = .All
                for pair in values {
                    print("\(pair.key.toString(child: false)) - \(pair.value)")
                }
                action = 4
                
            }
            
            currentValue = mode.childNames() ? 5.0 : 0.0
        }
        
        func getTextForEnvironment() -> String {
            let billieName = currentBillie.toString(child: mode.childNames())
            var text = ""
            
            switch mode{
                case .child:
                    text = BILLIE_CHILD
                case .parent:
                    text = BILLIE_PARENT
                default:
                    text = BILLIE_ADULT
            }

            return text.replacingOccurrences(of: "...", with: billieName)
        }
        
        func getColor() -> Color {
            return isEditing ? Color(PHR_PURPLE) : Color(PHR_ORANGE)
        }
        
        func saveValues() {
            values[currentBillie] = currentValue
        }
    }
}
