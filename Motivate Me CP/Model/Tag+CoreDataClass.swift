//
//  Tag+CoreDataClass.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/2/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject {
    convenience init(moc: NSManagedObjectContext, title: String)  {
        guard let entity = NSEntityDescription.entity(forEntityName: "Tag", in: moc) else {
            fatalError("Failed to create Tag")
        }
        
        self.init(entity: entity, insertInto: moc)
        self.title = title
    }
}
