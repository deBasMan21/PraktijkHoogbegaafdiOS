//
//  EnumExtension.swift
//  PhriOS
//
//  Created by Bas Buijsen on 09/04/2022.
//

import Foundation

extension RawRepresentable where RawValue: CustomStringConvertible {
    var description: String {
        return rawValue.description
    }
}
