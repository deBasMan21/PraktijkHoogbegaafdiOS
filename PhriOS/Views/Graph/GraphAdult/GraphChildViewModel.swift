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
        @Published var mailData = ComposeMailData(subject: "Verslag uit de app", recipients: ["bbuijsen@gmail.com"], message: "In de bijlage zit het verslag van de intensiteiten. Dit is van .. tot en met ...", attachments: [])
        
        @Published var showShareOptions = false
        
        init() {
            loadData()
        }
        
        func loadData() {
            selectedGraph = .All
            entries = showChild ? getChildData(from: beginDate, to: endDate) : getParentData(from: beginDate, to: endDate)
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
            weekStats = getWeekStats(from: beginDate, to: endDate, child: showChild)
            dayStats = getDayStats(of: endDate, child: showChild)
        }
        
        func share(shareOptions : ShareType) async {
            images = []
            
            if shareOptions == .both {
                showChild = true
                for _ in 0...1 {
                    await createScreenshots()
                    await MainActor.run{
                        showChild = false
                    }
                }
            } else if shareOptions == .childOnly {
                showChild = true
                await createScreenshots()
            } else if shareOptions == .parentOnly {
                showChild = false
                await createScreenshots()
            }
            
            await createMail(shareOptions: shareOptions)
        }
        
        func createMail(shareOptions : ShareType) async {
            await MainActor.run{
                selectedGraph = .All
                mailData.attachments = []
                
                mailData.message = mailData.message.replacingOccurrences(of: "...", with: "\(endDate.toString())")
                mailData.message = mailData.message.replacingOccurrences(of: "..", with: "\(beginDate.toString())")
                
                let parentStats = shareOptions == .both || shareOptions == .parentOnly ? getWeekStats(from: beginDate, to: endDate, child: false) : nil
                let childStats = shareOptions == .both || shareOptions == .childOnly ? getWeekStats(from: beginDate, to: endDate, child: true) : nil
                
                let pdf = createPDF(images: images, weekStatsParent: parentStats, weekStatsChild: childStats)
                mailData.attachments?.append(AttachmentData(data: pdf, mimeType: "application/pdf", fileName: "verslag.pdf"))
                
                showMail = true
            }
        }
        
        func createScreenshots() async {
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
