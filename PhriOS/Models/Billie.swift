//
//  Billie.swift
//  PhriOS
//
//  Created by Bas Buijsen on 06/04/2022.
//

import Foundation

enum Billie : String, CustomStringConvertible, CaseIterable {
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
}
