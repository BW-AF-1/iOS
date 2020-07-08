//
//  NewClass+CoreDataProperties.swift
//  
//
//  Created by Morgan Smith on 6/30/20.
//
//

import Foundation
import CoreData


extension NewClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewClass> {
        return NSFetchRequest<NewClass>(entityName: "NewClass")
    }

    @NSManaged public var classCurrentSizeCD: Int16
    @NSManaged public var classDateCD: Date
    @NSManaged public var classDurationCD: Int16
    @NSManaged public var classID: Int16
    @NSManaged public var classIdentifierCD: UUID?
    @NSManaged public var classLevelCD: String
    @NSManaged public var classLocationCD: String
    @NSManaged public var classMaxSizeCD: Int16
    @NSManaged public var classNameCD: String
    @NSManaged public var classTypeCD: String
    @NSManaged public var instructorID: Int16
    @NSManaged public var classInstructor: Instructor?
    @NSManaged public var registeredClients: NSSet?

}

// MARK: Generated accessors for registeredClients
extension NewClass {

    @objc(addRegisteredClientsObject:)
    @NSManaged public func addToRegisteredClients(_ value: Client)

    @objc(removeRegisteredClientsObject:)
    @NSManaged public func removeFromRegisteredClients(_ value: Client)

    @objc(addRegisteredClients:)
    @NSManaged public func addToRegisteredClients(_ values: NSSet)

    @objc(removeRegisteredClients:)
    @NSManaged public func removeFromRegisteredClients(_ values: NSSet)

}
