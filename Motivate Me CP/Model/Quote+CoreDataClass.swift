//
//  Quote+CoreDataClass.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/2/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Quote)
public class Quote: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case text = "quote"
        case topic
        case source
        case tags
    }
    
    // MARK: - Decodable
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Quote", in: managedObjectContext) else {
                fatalError("Failed to create Quote")
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let id    = try container.decodeIfPresent(String.self, forKey: .id),
              let text  = try container.decodeIfPresent(String.self, forKey: .text),
              let topic = try container.decodeIfPresent(String.self, forKey: .topic),
              let idInt64 = Int64(id) else {
                fatalError("Failed to decode Quote")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        
        let source = try Source(moc: managedObjectContext, title: container.decodeIfPresent(String.self, forKey: .source) ?? "Unknown")
        let tagsAsString: [String] = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        var tags: [Tag] = []
        for tagString in tagsAsString {
            tags.append(Tag(moc: managedObjectContext, title: tagString))
        }
        self.id     = idInt64
        self.text   = text
        self.topic  = topic
        self.source = source
        self.addToTags(NSSet(array: tags))
    }
}
