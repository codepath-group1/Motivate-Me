//
//  QuoteData+CoreDataProperties.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/9/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//
//

import Foundation
import CoreData


extension QuoteData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteData> {
        return NSFetchRequest<QuoteData>(entityName: "QuoteData")
    }

    @NSManaged public var results: NSSet?

}

// MARK: Generated accessors for results
extension QuoteData {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: Quote)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: Quote)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}
