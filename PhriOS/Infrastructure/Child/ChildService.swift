//
//  ChildService.swift
//  PhriOS
//
//  Created by Bas Buijsen on 09/04/2022.
//

import Foundation
import Charts

func getChildData(from: Date, to: Date) -> [ChartDataEntryWrapper] {
    return [ChartDataEntryWrapper(data: [
            ChartDataEntry(x: 1, y: 1),
            ChartDataEntry(x: 2, y: 3),
            ChartDataEntry(x: 3, y: 4),
            ChartDataEntry(x: 4, y: 3),
            ChartDataEntry(x: 5, y: 5),
            ChartDataEntry(x: 6, y: 3),
            ChartDataEntry(x: 7, y: 1)]
            , color: .red, billie: .Emoto),
        ChartDataEntryWrapper(data: [
            ChartDataEntry(x: 1, y: 2),
            ChartDataEntry(x: 2, y: 1),
            ChartDataEntry(x: 3, y: 4),
            ChartDataEntry(x: 4, y: 6),
            ChartDataEntry(x: 5, y: 7),
            ChartDataEntry(x: 6, y: 9),
            ChartDataEntry(x: 7, y: 6)]
            , color: .green, billie: .Fanti),
               ChartDataEntryWrapper(data: [
                   ChartDataEntry(x: 1, y: 7),
                   ChartDataEntry(x: 2, y: 6),
                   ChartDataEntry(x: 3, y: 7),
                   ChartDataEntry(x: 4, y: 8),
                   ChartDataEntry(x: 5, y: 5),
                   ChartDataEntry(x: 6, y: 6),
                   ChartDataEntry(x: 7, y: 5)]
                                     , color: .orange, billie: .Senzo),
               ChartDataEntryWrapper(data: [
                   ChartDataEntry(x: 1, y: 10),
                   ChartDataEntry(x: 2, y: 9),
                   ChartDataEntry(x: 3, y: 9),
                   ChartDataEntry(x: 4, y: 10),
                   ChartDataEntry(x: 4.3, y: 8),
                   ChartDataEntry(x: 4.6, y: 7),
                   ChartDataEntry(x: 5, y: 6),
                   ChartDataEntry(x: 6, y: 8),
                   ChartDataEntry(x: 7, y: 9)]
                                     , color: .purple, billie: .Intellecto),
               ChartDataEntryWrapper(data: [
                   ChartDataEntry(x: 1, y: 5),
                   ChartDataEntry(x: 2, y: 6),
                   ChartDataEntry(x: 3, y: 4),
                   ChartDataEntry(x: 4, y: 5),
                   ChartDataEntry(x: 5, y: 3),
                   ChartDataEntry(x: 6, y: 5),
                   ChartDataEntry(x: 7, y: 8),
                   ChartDataEntry(x: 7.5, y: 7)]
                                     , color: .blue, billie: .Psymo)]
}

func getParentData(from: Date, to: Date) -> [ChartDataEntryWrapper] {
    return [ChartDataEntryWrapper(data: [
        ChartDataEntry(x: 1, y: -1),
        ChartDataEntry(x: 2, y: 0),
        ChartDataEntry(x: 3, y: -1),
        ChartDataEntry(x: 4, y: -2),
        ChartDataEntry(x: 5, y: -2),
        ChartDataEntry(x: 6, y: 0),
        ChartDataEntry(x: 7, y: 1)]
        , color: .red, billie: .Emoto),
    ChartDataEntryWrapper(data: [
        ChartDataEntry(x: 1, y: 2),
        ChartDataEntry(x: 2, y: 1),
        ChartDataEntry(x: 3, y: 0),
        ChartDataEntry(x: 4, y: 0),
        ChartDataEntry(x: 5, y: 0),
        ChartDataEntry(x: 6, y: 0),
        ChartDataEntry(x: 7, y: 2)]
        , color: .green, billie: .Fanti),
           ChartDataEntryWrapper(data: [
               ChartDataEntry(x: 1, y: 2),
               ChartDataEntry(x: 2, y: 2),
               ChartDataEntry(x: 3, y: 1),
               ChartDataEntry(x: 4, y: 0),
               ChartDataEntry(x: 5, y: 1),
               ChartDataEntry(x: 6, y: 0),
               ChartDataEntry(x: 7, y: 2)]
                                 , color: .orange, billie: .Senzo),
           ChartDataEntryWrapper(data: [
               ChartDataEntry(x: 1, y: -1),
               ChartDataEntry(x: 2, y: 0),
               ChartDataEntry(x: 3, y: 0),
               ChartDataEntry(x: 4, y: -1),
               ChartDataEntry(x: 4.3, y: -1),
               ChartDataEntry(x: 4.6, y: -1),
               ChartDataEntry(x: 5, y: -2),
               ChartDataEntry(x: 6, y: -1),
               ChartDataEntry(x: 7, y: 0)]
                                 , color: .purple, billie: .Intellecto),
           ChartDataEntryWrapper(data: [
               ChartDataEntry(x: 1, y: 0),
               ChartDataEntry(x: 2, y: 1),
               ChartDataEntry(x: 3, y: -1),
               ChartDataEntry(x: 4, y: -2),
               ChartDataEntry(x: 5, y: 0),
               ChartDataEntry(x: 6, y: 1),
               ChartDataEntry(x: 7, y: 2),
               ChartDataEntry(x: 7.5, y: 1)]
                                 , color: .blue, billie: .Psymo)]
}
