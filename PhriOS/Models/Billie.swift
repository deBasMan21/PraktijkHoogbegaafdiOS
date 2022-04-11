//
//  Billie.swift
//  PhriOS
//
//  Created by Bas Buijsen on 06/04/2022.
//

import Foundation

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
}
