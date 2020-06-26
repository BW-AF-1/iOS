//
//  Instructor+CoreDataProperties.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/25/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//
//

import Foundation
import CoreData


extension Instructor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Instructor> {
        return NSFetchRequest<Instructor>(entityName: "Instructor")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var website: String?
    @NSManaged public var createdClasses: NSSet

}

// MARK: Generated accessors for createdClasses
extension Instructor {

    @objc(addCreatedClassesObject:)
    @NSManaged public func addToCreatedClasses(_ value: NewClass)

    @objc(removeCreatedClassesObject:)
    @NSManaged public func removeFromCreatedClasses(_ value: NewClass)

    @objc(addCreatedClasses:)
    @NSManaged public func addToCreatedClasses(_ values: NSSet)

    @objc(removeCreatedClasses:)
    @NSManaged public func removeFromCreatedClasses(_ values: NSSet)

}
