//
//  GraphViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation
import Charts

extension GraphView {
    class ViewModel : ObservableObject {
        @Published var days = ["1", "2", "3", "4", "5", "6", "7"]
        @Published var entries : [ChartDataEntryWrapper] = []
        @Published var filteredEntries : [ChartDataEntryWrapper] = []
        @Published var selectedGraph : Billie = .All
        @Published var weekStats : [Billie : Double] = [:]
        @Published var dayStats : [Billie: Double] = [:]
        @Published var beginDate : Date = Date().addingTimeInterval(-60 * 60 * 24 * 6)
        @Published var endDate : Date = Date()
        
        init() {
            loadData()
            loadStats()
            filteredEntries = entries
            print(beginDate)
            print(endDate)
        }
        
        func loadData() {
            entries = [ChartDataEntryWrapper(data: [
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
        
        func filter(){
            var filtered : [ChartDataEntryWrapper] = []
            for entry in entries {
                if entry.billie == selectedGraph || selectedGraph == .All {
                    filtered.append(entry)
                }
            }
            filteredEntries = filtered
        }
        
        func loadStats() {
            for entry in entries {
                var totalValue : Double = 0
                var count : Double = 0
                for data in entry.data {
                    count += 1
                    totalValue += data.y
                }
                weekStats[entry.billie] = round(totalValue / count * 10) / 10
            }
            
            for entry in entries {
                var totalValue : Double = 0
                var count : Double = 0
                for data in entry.data {
                    if Int(data.x) == 7 {
                        count += 1
                        totalValue += data.y
                    }
                }
                dayStats[entry.billie] = round(totalValue / count * 10) / 10
            }
        }
    }
}
