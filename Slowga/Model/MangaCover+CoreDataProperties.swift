//
//  MangaCover+CoreDataProperties.swift
//  
//
//  Created by Deshun Cai on 3/11/18.
//
//

import Foundation
import CoreData


extension MangaCover {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MangaCover> {
        return NSFetchRequest<MangaCover>(entityName: "MangaCover")
    }

    @NSManaged public var hits: Int64
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?

}
