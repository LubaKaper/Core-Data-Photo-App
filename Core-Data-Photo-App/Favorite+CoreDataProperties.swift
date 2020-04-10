//
//  Favorite+CoreDataProperties.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var image: String?
    @NSManaged public var userName: String?
    @NSManaged public var likes: Int16
    @NSManaged public var favoritedBy: Int16
    @NSManaged public var tag: String?
    @NSManaged public var newRelationship: User?

}
