//
//  Client+CoreDataProperties.swift
//  
//
//  Created by Morgan Smith on 6/30/20.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var clientID: Int16
    @NSManaged public var email: String
    @NSManaged public var password: String
    @NSManaged public var registeredClasses: NSSet?

}

// MARK: Generated accessors for registeredClasses
extension Client {

    @objc(addRegisteredClassesObject:)
    @NSManaged public func addToRegisteredClasses(_ value: NewClass)

    @objc(removeRegisteredClassesObject:)
    @NSManaged public func removeFromRegisteredClasses(_ value: NewClass)

    @objc(addRegisteredClasses:)
    @NSManaged public func addToRegisteredClasses(_ values: NSSet)

    @objc(removeRegisteredClasses:)
    @NSManaged public func removeFromRegisteredClasses(_ values: NSSet)

}
