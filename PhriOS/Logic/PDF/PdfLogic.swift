//
//  PdfLogic.swift
//  PhriOS
//
//  Created by Bas Buijsen on 10/04/2022.
//

import Foundation
import SwiftUI
import Charts
import PDFKit

func createPDF(images : [UIImage], weekStatsParent : [Billie : Double]?, weekStatsChild : [Billie : Double]?) -> Data {
    let logo = UIImage(named: "Logo")!
    let defs = UserDefaults()
    let adultMode = defs.bool(forKey: "adultMode")
    
    let pdfMetaData = [
      kCGPDFContextCreator: "Praktijk Hoogbegaafd",
      kCGPDFContextAuthor: "praktijkhoogbegaafd.nl"
    ]
    
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]

    let pageWidth = images[0].size.width * 3
    let pageHeight = (images[0].size.height * (CGFloat(images.count) / 3)) + 600 + logo.size.height
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)


    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

    let data = renderer.pdfData { (context) in

        context.beginPage()

        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 72)
        ]
        
        let attributesOrange = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72),
            NSAttributedString.Key.foregroundColor : UIColor(named: "PhrOrange")!
        ]
        
        let attributesPurple = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72),
        NSAttributedString.Key.foregroundColor : UIColor(named: "PhrPurple")!
        ]
        
        logo.draw(at: CGPoint(x: (pageWidth - logo.size.width) / 2, y: 0))

        var rowCount = 0
        var columnCount = 0
        
        for img in images {
            img.draw(at: CGPoint(x: img.size.width * CGFloat(columnCount), y: img.size.height * CGFloat(rowCount) + logo.size.height))
            
            columnCount += 1
            if columnCount == 3 {
                rowCount += 1
                columnCount = 0
            }
        }
        
        let weekParentTitle = adultMode ? "Weekstatistieken ouder:" : "Weekstatistieken:"
        let weekChildTitle = "Weekstatistieken kind:"
        
        let statsY = (images[0].size.height * CGFloat(images.count / 3)) + logo.size.height + 50
        let statsChildX = weekStatsParent != nil ? (pageWidth - logo.size.width) / 2 : 50
        
        if weekStatsParent != nil {
            weekParentTitle.draw(at: CGPoint(x: 50, y: statsY), withAttributes: attributesPurple)
            var index = 0
            for stat in weekStatsParent! {
                index += 1
                let key = "\(stat.key.toString(child: false)):"
                key.draw(at: CGPoint(x: 50, y: statsY + (CGFloat(index) * 76)), withAttributes: attributes)
                stat.value.description.draw(at: CGPoint(x: 800, y: statsY + (CGFloat(index) * 76)), withAttributes: attributesOrange)
            }
        }
        
        if weekStatsChild != nil {
            weekChildTitle.draw(at: CGPoint(x: statsChildX, y: statsY), withAttributes: attributesPurple)
            var index = 0
            for stat in weekStatsChild! {
                index += 1
                let key = "\(stat.key.toString(child: false)):"
                key.draw(at: CGPoint(x: statsChildX, y: statsY + (CGFloat(index) * 76)), withAttributes: attributes)
                stat.value.description.draw(at: CGPoint(x: statsChildX + 800, y: statsY + (CGFloat(index) * 76)), withAttributes: attributesOrange)
            }
        }
        
    }
    
    return data
}
