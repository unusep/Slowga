//
//  CoreDataMock.swift
//  SlowgaTests
//
//  Created by Deshun Cai on 12/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import Foundation
import CoreData


class CoreDataMock {
    static let shared = CoreDataMock()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        let container = NSPersistentContainer(name: "Slowga", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
}
