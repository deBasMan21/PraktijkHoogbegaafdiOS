//
//  DateExtension.swift
//  PhriOS
//
//  Created by Bas Buijsen on 10/04/2022.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
