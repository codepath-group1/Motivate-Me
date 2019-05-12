//
//  Quote+CoreDataProperties.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/12/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote")
    }

    @NSManaged public var favoritedAt: NSDate?
    @NSManaged public var id: Int64
    @NSManaged public var isFavorited: Bool
    @NSManaged public var text: String?
    @NSManaged public var topic: String?
    @NSManaged public var quoteData: QuoteData?
    @NSManaged public var source: Source?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for tags
extension Quote {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
