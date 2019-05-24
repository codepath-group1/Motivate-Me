//
//  QuoteData+CoreDataClass.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/9/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//
//

import Foundation
import CoreData

@objc(QuoteData)
public class QuoteData: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    // MARK: - Decodable
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "QuoteData", in: managedObjectContext) else {
                fatalError("Failed to create QuoteData")
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let results = try container.decodeIfPresent(Set<Quote>.self, forKey: .results) else {
            fatalError("Failed to create results")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        self.addToResults(NSSet(set: results)) 
    }
}
