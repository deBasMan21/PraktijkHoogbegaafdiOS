//
//  MultiLineChartView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import SwiftUI
import Charts

struct MultiLineChartView : UIViewRepresentable {
    
    @Binding var lines : [ChartDataEntryWrapper]
    var style : ChartStyle
    var child : Bool
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        return createChart(chart: chart)
    }
    
    func updateUIView(_ chart: LineChartView, context: Context) {
        chart.data = addData()
    }
    
    func createChart(chart: LineChartView) -> LineChartView{
        chart.chartDescription?.enabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawLabelsEnabled = true
        chart.xAxis.drawAxisLineEnabled = true
        chart.xAxis.labelPosition = .bottom
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = true
        chart.drawBordersEnabled = true
        chart.legend.form = .default
        chart.xAxis.forceLabelsEnabled = true
        chart.xAxis.granularityEnabled = true
        chart.xAxis.granularity = 1
        chart.xAxis.axisMinimum = style.minX
        chart.xAxis.axisMaximum = style.maxX
        chart.scaleXEnabled = false
        chart.scaleYEnabled = false
        chart.leftAxis.axisMinimum = style.minY
        chart.leftAxis.axisMaximum = style.maxY
        chart.leftAxis.granularity = 1
        
        chart.data = addData()
        return chart
    }
    
    func addData() -> LineChartData{
        var dataSets : [LineChartDataSet] = []
        for line in lines{
            dataSets.append(generateLineChartDataSet(entries: line))
        }
        let data = LineChartData(dataSets: dataSets)
        return data
    }
    
    func filter(billie : Billie) -> LineChartData {
        var dataSets : [LineChartDataSet] = []
        for line in lines{
            dataSets.append(generateLineChartDataSet(entries: line))
        }
        let data = LineChartData(dataSets: dataSets)
        return data
    }
    
    func generateLineChartDataSet(entries : ChartDataEntryWrapper) -> LineChartDataSet{
        let dataSet = LineChartDataSet(entries: entries.data, label: "")
        dataSet.colors = [UIColor(entries.color)]
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.valueTextColor = .clear
        dataSet.label = entries.billie.toString(child: child)
        return dataSet
    }
    
}

class ChartDataEntryWrapper {
    var data : [ChartDataEntry]
    var color : Color
    var billie : Billie
    
    init(data: [ChartDataEntry], color : Color, billie: Billie) {
        self.data = data
        self.color = color
        self.billie = billie
    }
}

class ChartStyle {
    var minX : Double
    var maxX : Double
    var minY : Double
    var maxY : Double
    
    init(minX : Double, maxX : Double, minY : Double, maxY : Double) {
        print(maxX)
        self.minX = minX
        self.maxX = Double(Int(maxX) + 1)
        self.minY = minY
        self.maxY = maxY
        print(self.maxX)
    }
}
