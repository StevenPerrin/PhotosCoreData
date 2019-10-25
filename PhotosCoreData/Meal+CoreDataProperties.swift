//
//  Meal+CoreDataProperties.swift
//  PhotosCoreData
//
//  Created by Steven Perrin on 10/24/19.
//  Copyright © 2019 Steven Perrin. All rights reserved.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var rawDate: Date?
    @NSManaged public var rawImage: Data?

}
