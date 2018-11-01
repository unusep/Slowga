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
    public func getLocalImageFilePath() -> String? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        guard let title = self.title else {
            return nil
        }
        let pathComponent = String(format: "Media/Manga/%@/%@", title, "cover_image")
        let fileURL = documentsURL.appendingPathComponent(pathComponent)
        return fileURL.path
    }
}
