//
//  MangaCover+CoreDataClass.swift
//  
//
//  Created by Deshun Cai on 31/10/18.
//
//

import Foundation
import CoreData


public class MangaCover: NSManagedObject {
    var imageFilePath: String? {
        get {
            if imageIsDownloaded, let file = imageUrl {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(file)
                return fileURL.path
            } else {
                return nil
            }
        }
    }
}
