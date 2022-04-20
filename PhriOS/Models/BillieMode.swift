//
//  BillieMode.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation

enum BillieMode : String, CustomStringConvertible {
    case child
    case parent
    case adult
    
    func childNames() -> Bool {
        switch self{
            case .child:
                return true
            default:
                return false
        }
    }
    
    static func fromBools(adultMode: Bool, showChild: Bool) -> BillieMode{
        if adultMode {
            return .adult
        } else {
            if showChild {
                return .child
            } else {
                return .parent
            }
        }
    }
}
