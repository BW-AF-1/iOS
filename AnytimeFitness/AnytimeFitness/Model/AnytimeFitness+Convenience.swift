//
//  Client+Convenience.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/23/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation
import CoreData

extension Client {

    var clientRepresentation: ClientRepresentation? {
        return ClientRepresentation(email: email, password: password, clientID: Int(clientID))
    }
    
    @discardableResult convenience init(email: String,
                                        password: String,
                                        clientID: Int16,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.email = email
        self.password = password
        self.clientID = clientID
    }
    @discardableResult convenience init?(clientRepresentation: ClientRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(email: clientRepresentation.email, password: clientRepresentation.password, clientID: Int16(clientRepresentation.clientID ?? 0))
    }
}

extension Instructor {
    var instructorRepresentation: InstructorRepresentation? {
        return InstructorRepresentation(email: email, password: password, instructorID: Int(instructorID))
    }
    
    @discardableResult convenience init(email: String,
                                        password: String,
                                        instructorID: Int16,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.email = email
        self.password = password
        self.instructorID = instructorID
    }
    @discardableResult convenience init?(instructorRepresentation: InstructorRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
       self.init(email: instructorRepresentation.email, password: instructorRepresentation.password, instructorID: Int16(instructorRepresentation.instructorID ?? 0))
     }
}


extension NewClass {
    var classRepresentation: ClassRepresentation? {

        return ClassRepresentation(classDateCD: classDateCD.description, classDurationCD: String(classDurationCD), classLevelCD: classLevelCD, classLocationCD: classLocationCD, classMaxSizeCD: Int(classMaxSizeCD), classCurrentSizeCD: Int(classCurrentSizeCD), classNameCD: classNameCD, classTypeCD: classTypeCD, instructorID: Int(instructorID))

    }
    @discardableResult convenience init(classDateCD: Date,
                                        classDurationCD: Int16,
                                        classLevelCD: String,
                                        classLocationCD: String,
                                        classMaxSizeCD: Int16,
                                        classCurrentSizeCD: Int16 = 0,
                                        classNameCD: String,
                                        classTypeCD: String,
                                        classIdentifierCD: UUID = UUID(),
                                        instructorID: Int16,
                                        classID: Int16? = 0,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.classDateCD = classDateCD
        self.classDurationCD = classDurationCD
        self.classLevelCD = classLevelCD
        self.classLocationCD = classLocationCD
        self.classMaxSizeCD = classMaxSizeCD
        self.classCurrentSizeCD = classCurrentSizeCD
        self.classNameCD = classNameCD
        self.classTypeCD = classTypeCD
        self.classIdentifierCD = classIdentifierCD
        self.instructorID = instructorID
        self.classID = classID ?? 0
    }

    @discardableResult convenience init?(classRepresentation: ClassRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        let isoDate = classRepresentation.classDateCD
        let dateFormatter = ISO8601DateFormatter()
        let classDate = dateFormatter.date(from:isoDate)!

        self.init(classDateCD: classDate, classDurationCD: Int16(classRepresentation.classDurationCD) ?? 0, classLevelCD: classRepresentation.classLevelCD, classLocationCD: classRepresentation.classLocationCD, classMaxSizeCD: Int16(classRepresentation.classMaxSizeCD), classCurrentSizeCD: Int16(classRepresentation.classCurrentSizeCD), classNameCD: classRepresentation.classNameCD, classTypeCD: classRepresentation.classTypeCD, classIdentifierCD: classRepresentation.classIdentifierCD ?? UUID(), instructorID: Int16(classRepresentation.instructorID), classID: Int16(classRepresentation.classID ?? 0))
    }
}


