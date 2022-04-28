//
//  DisabledViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 15/04/2022.
//

import Foundation
import SwiftUI
import CoreData

extension DisabledView {
    class ViewModel : ObservableObject {
        @Published var isValid = false
        
        init(){
            
        }
        
        func canAddData(moc : NSManagedObjectContext, mode : BillieMode) {
            let req  : NSFetchRequest<BillieValueEntity> = BillieValueEntity.fetchRequest()
            
            let modePredicate = NSPredicate(format: "mode == %@", mode.description)
            let beginDatePredicate = NSPredicate(format: "dateTime <= %@", Date().toDate().addingTimeInterval(60 * 60 * 24) as CVarArg)
            let endDatePredicate = NSPredicate(format: "dateTime > %@", Date().toDate() as CVarArg)
            
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [modePredicate, beginDatePredicate, endDatePredicate])
            
            req.predicate = andPredicate
            
            do {
                let array = try moc.fetch(req) as [BillieValueEntity]
                isValid = array.count / 5 < 3
            } catch _ {
                isValid = false
            }
        }
    }
}
