//
//  Source+CoreDataClass.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/2/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Source)
public class Source: NSManagedObject {
    convenience init(moc: NSManagedObjectContext, title: String)  {
        guard let entity = NSEntityDescription.entity(forEntityName: "Source", in: moc) else {
                fatalError("Failed to create Source")
        }
        
        self.init(entity: entity, insertInto: moc)
        self.title = title
    }
}
