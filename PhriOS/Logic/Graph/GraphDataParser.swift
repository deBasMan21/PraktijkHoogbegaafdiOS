//
//  GraphDataParser.swift
//  PhriOS
//
//  Created by Bas Buijsen on 12/04/2022.
//

import Foundation
import Charts

func parseObjectsToGraph(values : [BillieValueEntity], amountOfDays : Int, minDate : Date, maxDate : Date) -> [ChartDataEntryWrapper]{
    var split : [Billie : [BillieValueEntity]] = [:]
    for value in values {
        if split[Billie.getBillieFromInt(key: Int(value.billie))] == nil {
            split[Billie.getBillieFromInt(key: Int(value.billie))] = []
        }
        split[Billie.getBillieFromInt(key: Int(value.billie))]?.append(value)
    }
    
    var returnList : [ChartDataEntryWrapper] = []
    

    
    for pair in split {
        var chartData : [ChartDataEntry] = []
        var splitPerDay : [Date : [BillieValueEntity]] = [:]
        
        for day in 0...amountOfDays {
            splitPerDay[minDate.addingTimeInterval(Double(day * 60 * 60 * 24)).toDate()] = []
        }
        
        for value in pair.value {
            if splitPerDay[value.dateTime!.toDate()] == nil {
                splitPerDay[value.dateTime!.toDate()] = []
            }
            splitPerDay[value.dateTime!.toDate()]?.append(value)
        }
        
        var index = Double(amountOfDays)
        for tuple in splitPerDay.sorted(by: { $0.0 > $1.0}){
            print(tuple.key)
            print(index)
            let amount = Double(tuple.value.count)
            let incrementAmount : Double = 1 / amount
            
            if tuple.value.count > 0 {
                for i in 0...tuple.value.count - 1 {
                    var tempChartdata : [ChartDataEntry] = []
                    let x : Double = index + (Double(i) * incrementAmount)
                    let y = tuple.value[i].value
                    tempChartdata.append(ChartDataEntry(x: x, y: y))
                    chartData.append(contentsOf:tempChartdata)
                }
            }
            
            index -= 1
        }
        
//        print(pair.key.description)
//        for v in chartData {
//            print("x: \(v.x) y: \(v.y)")
//        }
        
        chartData = chartData.sorted(by: {$0.x < $1.x})
        returnList.append(ChartDataEntryWrapper(data: chartData, color: pair.key.getColor(), billie: pair.key))
    }
    return returnList
}

