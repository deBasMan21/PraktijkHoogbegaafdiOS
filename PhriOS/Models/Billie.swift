//
//  Billie.swift
//  PhriOS
//
//  Created by Bas Buijsen on 06/04/2022.
//

import Foundation
import SwiftUI

enum Billie : String, CustomStringConvertible, CaseIterable, Comparable {
    static func < (lhs: Billie, rhs: Billie) -> Bool {
        return lhs.getIntKey() < rhs.getIntKey()
    }
    
    case All
    case Emoto
    case Psymo
    case Fanti
    case Senzo
    case Intellecto
    
    func getColor() -> Color {
        switch self{
        case .Emoto:
            return .red
        case .Psymo:
            return .blue
        case .Fanti:
            return .green
        case .Senzo:
            return .orange
        case .Intellecto:
            return .purple
        default:
            return .gray
        }
    }
    
    func toString(child : Bool) -> String {
        switch self{
        case .All:
            return "Alles"
        case .Emoto:
            return !child ? "Emotioneel" : "Emoto"
        case .Psymo:
            return !child ? "Psychomotorisch" : "Psymo"
        case .Fanti:
            return !child ? "Beeldend" : "Fanti"
        case .Senzo:
            return !child ? "Sensorisch" : "Senzo"
        case .Intellecto:
            return !child ? "Intellectueel" : "Intellecto"
        }
    }
    
    func toIntensityString() -> String{
        switch self{
        case .All:
            return "Alles"
        case .Emoto:
            return "Emotionele intensiteit"
        case .Psymo:
            return "Psychomotorische intensiteit"
        case .Fanti:
            return "Beeldende intensiteit"
        case .Senzo:
            return "Sensorische intensiteit"
        case .Intellecto:
            return "Intellectuele intensiteit"
        }
    }
    
    func getIntKey() -> Int {
        switch self{
        case .All:
            return 0
        case .Emoto:
            return 1
        case .Psymo:
            return 2
        case .Fanti:
            return 3
        case .Senzo:
            return 4
        case .Intellecto:
            return 5
        }
    }
    
    static func getBillieFromInt(key : Int) -> Billie {
        switch key{
        case 1:
            return .Emoto
        case 2:
            return .Psymo
        case 3:
            return .Fanti
        case 4:
            return .Senzo
        case 5:
            return .Intellecto
        default:
            return .All
        }
    }
}
