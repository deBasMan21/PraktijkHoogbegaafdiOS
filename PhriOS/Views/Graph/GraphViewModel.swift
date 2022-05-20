//
//  GraphViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation
import Charts
import SwiftUI
import CoreData
import MessageUI

extension GraphView {
    class ViewModel : ObservableObject {
        @Published var adultMode : Bool = false
        @Published var showChild = true
        @Published var withPhr = false
        @Published var name = ""
        
        @Published var entries : [ChartDataEntryWrapper] = []
        @Published var filteredEntries : [ChartDataEntryWrapper] = []
        
        @Published var selectedGraph : Billie = .All
        
        @Published var weekStats : [Billie : Double] = [:]
        @Published var dayStats : [Billie: Double] = [:]
        
        @Published var endDate : Date = Date().toDate()
        
        @Published var geo : GeometryProxy? = nil
        @Published var images : [UIImage] = []
        
        @Published var showMail = false
        @Published var mailData = ComposeMailData(subject: EMAIL_SUBJECT, recipients: [], message: EMAIL_BODY, attachments: [])
        
        @Published var showShareOptions = false
        @Published var showShareWithPhrOptions = false
        @Published var selectedShareOptions : ShareType? = nil
        
        @Published var graphId = 2
        
        let defs = UserDefaults()
        var moc : NSManagedObjectContext? = nil
        
        init() {
            adultMode = defs.bool(forKey: DEFS_ADULT_MODE)
            withPhr = defs.bool(forKey: DEFS_WITH_PHR)
            name = defs.string(forKey: DEFS_NAME) ?? ""
            if adultMode {
                showChild = false
            }
        }
        
        func loadData(){
            selectedGraph = .All
            
            let req  : NSFetchRequest<BillieValueEntity> = BillieValueEntity.fetchRequest()
            
            let modePredicate = NSPredicate(format: "mode == %@", BillieMode.fromBools(adultMode: adultMode, showChild: showChild).description)
            let beginDatePredicate = NSPredicate(format: "dateTime >= %@", endDate.addingTimeInterval(-60 * 60 * 24 * 7) as CVarArg)
            let endDatePredicate = NSPredicate(format: "dateTime <= %@", endDate.addingTimeInterval(60 * 60 * 24 * 2) as CVarArg)
            
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [modePredicate, beginDatePredicate, endDatePredicate])
            
            let sorter = NSSortDescriptor(key: #keyPath(BillieValueEntity.dateTime), ascending: true)
            
            req.sortDescriptors = [sorter]
            req.predicate = andPredicate
            
            do {
                let array = try moc!.fetch(req) as [BillieValueEntity]
                entries = parseObjectsToGraph(values: array, amountOfDays: 7, maxDate: endDate.addingTimeInterval(60 * 60 * 24))
                filteredEntries = entries
                loadStats()
            } catch let error {
                print(error)
            }
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
            weekStats = getWeekStats(mode: BillieMode.fromBools(adultMode: adultMode, showChild: showChild))
            dayStats = getDayStats(mode: BillieMode.fromBools(adultMode: adultMode, showChild: showChild))
        }
        
        func getWeekStats(mode : BillieMode) -> [Billie : Double]{
            let req  : NSFetchRequest<BillieValueEntity> = BillieValueEntity.fetchRequest()
            
            let modePredicate = NSPredicate(format: "mode == %@", mode.description)
            let beginDatePredicate = NSPredicate(format: "dateTime >= %@", endDate.addingTimeInterval(-60 * 60 * 24 * 7) as CVarArg)
            let endDatePredicate = NSPredicate(format: "dateTime <= %@", endDate.addingTimeInterval(60 * 60 * 24 * 2) as CVarArg)
            
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [modePredicate, beginDatePredicate, endDatePredicate])
            
            req.predicate = andPredicate
            
            do {
                let array = try moc!.fetch(req) as [BillieValueEntity]
                return calculateStats(values: array)
            } catch let error {
                print(error)
            }
            
            return [:]
        }
        
        func getDayStats(mode : BillieMode) -> [Billie : Double]{
            let req  : NSFetchRequest<BillieValueEntity> = BillieValueEntity.fetchRequest()
            
            let modePredicate = NSPredicate(format: "mode == %@", mode.description)
            let beginDatePredicate = NSPredicate(format: "dateTime <= %@", endDate.toDate().addingTimeInterval(60 * 60 * 24) as CVarArg)
            let endDatePredicate = NSPredicate(format: "dateTime > %@", endDate.toDate() as CVarArg)
            
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [modePredicate, beginDatePredicate, endDatePredicate])
            
            req.predicate = andPredicate
            
            do {
                let array = try moc!.fetch(req) as [BillieValueEntity]
                return calculateStats(values: array)
            } catch let error {
                print(error)
            }
            
            return [:]
        }
        
        func share(shareOptions : ShareType) async {
            selectedShareOptions = shareOptions
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
            
            if withPhr {
                if await MFMailComposeViewController.canSendMail() {
                    await MainActor.run{
                        showShareWithPhrOptions = true
                    }
                } else {
                    await saveWithOptions(shareOptions: shareOptions)
                }
            } else {
                await saveWithOptions(shareOptions: shareOptions)
            }
        }
        
        func choseShareOptions(mail: Bool) async {
            if let selectedShareOptions = selectedShareOptions {
                if mail {
                    await createMail(shareOptions: selectedShareOptions)
                } else {
                    await saveWithOptions(shareOptions: selectedShareOptions)
                }
            } else {
                print("no share type defined")
            }
        }
        
        func createMail(shareOptions : ShareType) async {
            await MainActor.run{
                selectedGraph = .All
                mailData.attachments = []
                
                let emailRecipient = BEGELEIDSTERS[defs.string(forKey: DEFS_BEGELEIDSTER) ?? ""] ?? EMAIL_DEFAULT_ADRESS
                mailData.recipients = [emailRecipient]
                
                mailData.message = mailData.message.replacingOccurrences(of: "...", with: "\(endDate.toString())")
                mailData.message = mailData.message.replacingOccurrences(of: "..", with: "\(endDate.addingTimeInterval(60 * 60 * 24 * -7).toString())")
                
                let parentStats = shareOptions == .both || shareOptions == .parentOnly ? getWeekStats(mode: adultMode ? .adult : .parent) : nil
                let childStats = shareOptions == .both || shareOptions == .childOnly ? getWeekStats(mode: .child) : nil
                
                let pdf = createPDF(images: images, weekStatsParent: parentStats, weekStatsChild: childStats)
                mailData.attachments?.append(AttachmentData(data: pdf, mimeType: "application/pdf", fileName: "verslag.pdf"))
            
                showMail = true
            }
        }
        
        // loops to set the graph and take a screenshot
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
        
        // takes the screenshot from the view
        func takeScreenshot() -> UIImage? {
            guard let window = UIApplication.shared.keyWindow else {
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
        
        // pops up the options for saving or sharing a pdf
        func saveWithOptions(shareOptions : ShareType) async {
            let parentStats = shareOptions == .both || shareOptions == .parentOnly ? getWeekStats(mode: adultMode ? .adult : .parent) : nil
            let childStats = shareOptions == .both || shareOptions == .childOnly ? getWeekStats(mode: .child) : nil
            
            let pdfData = createPDF(images: images, weekStatsParent: parentStats, weekStatsChild: childStats)
            
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            let url = paths[0].appendingPathComponent("\(createFileName()).pdf")
            
            do {
                try pdfData.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
            
            let activityController = await UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            await MainActor.run{
                UIApplication.shared.keyWindow!.rootViewController!.present(activityController, animated: true, completion: nil)
            }
        }
        
        func createFileName() -> String {
            return "verslag \(name) \(Date().toString())"
        }
        
        func getShareString() -> String {
            if withPhr {
                if adultMode {
                    return SHARE_STRING_ADULT
                } else {
                    return SHARE_STRING_PARENT
                }
            } else {
                if adultMode{
                    return SHARE_STRING_NO_PHR_ADULT
                } else {
                    return SHARE_STRING_NO_PHR_PARENT
                }
            }
        }
    }
}
