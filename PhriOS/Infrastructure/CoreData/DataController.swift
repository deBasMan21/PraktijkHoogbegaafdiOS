//
//  DataController.swift
//  PhriOS
//
//  Created by Bas Buijsen on 12/04/2022.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "Phr")
    
    init(){
        container.loadPersistentStores(completionHandler: {description, error in
            if let error = error {
                print(error)
            }
        })
    }
}
