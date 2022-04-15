//
//  HomeViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 04/04/2022.
//

import Foundation
import CoreData
import SwiftUI

extension HomeView {
    class ViewModel : ObservableObject {
        @Published var adultMode  = false
        @Published var action: Int? = 0
        
        
        let defs = UserDefaults()
        
        init(){
            adultMode = defs.bool(forKey: DEFS_ADULT_MODE)
        }
        
        func canAddData(moc : NSManagedObjectContext, mode : BillieMode) -> Bool {
            let req  : NSFetchRequest<BillieValueEntity> = BillieValueEntity.fetchRequest()
            
            let modePredicate = NSPredicate(format: "mode == %@", mode.description)
            let sameDatePredicate = NSPredicate(format: "dateTime == %@", Date().toDate() as CVarArg)
            
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [modePredicate, sameDatePredicate])
            
            req.predicate = andPredicate
            
            do {
                let array = try moc.fetch(req) as [BillieValueEntity]
                return array.count < 3
            } catch let error {
                print(error)
            }
            return false
        }
    }
}
