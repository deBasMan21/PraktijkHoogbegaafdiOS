//
//  GraphViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation
import Charts
import SwiftUI

extension GraphAdultView {
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
        
        init() {
            loadData()
        }
        
        func loadData() {
            selectedGraph = .All
            if showChild {
                entries = [ChartDataEntryWrapper(data: [
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
            } else {
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
        
        func switchBot() async {
            images = []
            showChild = true
            for _ in 0...1 {
                for billie in Billie.allCases {
                    await MainActor.run{
                        selectedGraph = billie
                    }
                    do{
                        try await Task.sleep(nanoseconds: UInt64(NSEC_PER_SEC) / 16)
                    } catch {
                        print("oops")
                    }
                    await MainActor.run{
                        let img = takeScreenshot()
                        images.append(img ?? UIImage(named: "Logo")!)
//                        UIImageWriteToSavedPhotosAlbum(img ?? UIImage(named: "Logo")!, nil, nil, nil)
                    }
                }
                await MainActor.run{
                    showChild = false
                }
            }
            await MainActor.run{
                showChild = true
                selectedGraph = .All
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

extension UIImage {
  func cropped(boundingBox: CGRect, scale: CGFloat) -> UIImage? {
    let x = boundingBox.origin.x * scale
    let y = boundingBox.origin.y * scale
    let width = boundingBox.width * scale
    let height = boundingBox.height * scale

    let adjustedBoundingBox = CGRect(x: x, y: y, width: width, height: height)

    guard let cgImage = self.cgImage?.cropping(to: adjustedBoundingBox) else {
      print("UIImage.cropped: Couldn't create cropped image")
      return nil
    }

    return UIImage(cgImage: cgImage)
  }
}
