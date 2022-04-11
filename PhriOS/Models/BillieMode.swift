//
//  BillieMode.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation

enum BillieMode {
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
}
