//
//  GraphViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation
import Charts
import SwiftUI

extension GraphChildView {
    class ViewModel : ObservableObject {
        @Published var showChild = true
        
        @Published var entries : [ChartDataEntryWrapper] = []
        @Published var filteredEntries : [ChartDataEntryWrapper] = []
        
        @Published var selectedGraph : Billie = .All
        
        @Published var weekStats : [Billie : Double] = [:]
        @Published var dayStats : [Billie: Double] = [:]
        
        @Published var beginDate : Date = Date().addingTimeInterval(-60 * 60 * 24 * 6)
        @Published var endDate : Date = Date()
         
        @Published var geo : GeometryProxy? = nil
        @Published var images : [UIImage] = []
        
        @Published var showMail = false
        @Published var mailData = ComposeMailData(subject: "test", recipients: ["bbuijsen@gmail.com"], message: "test", attachments: [])
        
        init() {
            loadData()
        }
        
        func loadData() {
            selectedGraph = .All
            if showChild {
                entries = getChildData(from: beginDate, to: endDate)
            } else {
                entries = getParentData(from: beginDate, to: endDate)
            }
            filteredEntries = entries
            loadStats()
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
        
        func share() async {
            images = []
            showChild = true
            for _ in 0...1 {
                for billie in Billie.allCases {
                    await MainActor.run{
                        selectedGraph = billie
                    }
                    do{
                        try await Task.sleep(nanoseconds: UInt64(NSEC_PER_SEC) / 32)
                    } catch {
                        print("oops")
                    }
                    await MainActor.run{
                        let img = takeScreenshot()
                        images.append(img ?? UIImage(named: "Logo")!)
                    }
                }
                await MainActor.run{
                    showChild = false
                }
            }
            await MainActor.run{
                showChild = true
                selectedGraph = .All
                for index in 0...(images.count - 1) {
                    mailData.attachments?.append(AttachmentData(data: images[index].pngData()!, mimeType: "image/png", fileName: "img\(index).png"))
                }
                showMail = true
            }
        }
        
        func takeScreenshot() -> UIImage? {
          guard let window = UIApplication.shared.windows.first else {
            print("View.takeScreenshot: No main window found")
            return nil
          }

          UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
          let renderer = UIGraphicsImageRenderer(bounds: window.bounds, format: UIGraphicsImageRendererFormat())
          let image = renderer.image { (context) in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
          }
          UIGraphicsEndImageContext()

          let scale = UIScreen.main.scale
          let rect = CGRect(x: geo!.frame(in: .global).origin.x, y: geo!.frame(in: .global).origin.y, width: geo!.size.width, height: geo!.size.height)
          let croppedImage = image.cropped(boundingBox: rect, scale: scale)

          return croppedImage
        }
    }
}


