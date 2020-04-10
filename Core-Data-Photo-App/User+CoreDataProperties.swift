//
//  User+CoreDataProperties.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var newRelationship: NSSet?

}

// MARK: Generated accessors for newRelationship
extension User {

    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: Favorite)

    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: Favorite)

    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: NSSet)

    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: NSSet)

}
