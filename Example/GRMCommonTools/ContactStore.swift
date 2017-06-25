//
//  ContactStore.swift
//  GRMCommonTools
//
//  Created by Frederick Lee on 23/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import CoreData

class ContactStore {

    let persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error setting up Core Data \(error)")
            }
        }
        return container
    }()



}
