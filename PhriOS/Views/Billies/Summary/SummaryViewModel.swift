//
//  SummaryViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation
import SwiftUI
import CoreData

extension SummaryView {
    class ViewModel : ObservableObject {
        @Published var mode : BillieMode
        @Published var values : [Billie : Double]
        
        @Published var action : Int? = 0
        
        init(mode : BillieMode, values: [Billie: Double]){
            self.mode = mode
            self.values = values
        }
        
        func saveStats(moc : NSManagedObjectContext) {
            for value in values {
                let dataObj = BillieValueEntity(context: moc)
                dataObj.dateTime = Date()
                dataObj.billie = Int16(value.key.getIntKey())
                dataObj.mode = mode.description
                dataObj.value = value.value
                dataObj.id = UUID()
            }
            
            do{
                try moc.save()
            } catch let error{
                print(error)
            }
        }
    }
}
