//
//  Instructor+CoreDataProperties.swift
//  
//
//  Created by Morgan Smith on 6/30/20.
//
//

import Foundation
import CoreData


extension Instructor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Instructor> {
        return NSFetchRequest<Instructor>(entityName: "Instructor")
    }

    @NSManaged public var email: String
    @NSManaged public var instructorID: Int16
    @NSManaged public var password: String
    @NSManaged public var createdClasses: NSSet?

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
