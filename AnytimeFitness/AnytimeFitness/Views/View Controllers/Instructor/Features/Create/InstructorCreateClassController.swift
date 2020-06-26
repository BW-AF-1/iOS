//
//  InstructorCreateClassController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/24/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation
import UIKit

class InstructorCreateClassController {

    static let sharedInstructorCreateClassController = InstructorCreateClassController()

    var exampleClass: [ExampleClassType] = []

    struct ExampleClassType: Equatable, Codable {
        var className: String
        var classDate: Date
        var classLocation: String
        var classDuration: Int
        var classType: String
        var classLevel: String
        var classMaxSize: Int

        init(className: String = "Example Class", classDate: Date = Date(), classLocation: String = "Boston, MA", classDuration: Int = 10, classType: String = "Cardio", classLevel: String = "Beginner", classMaxSize: Int = 20) {
            self.className = className
            self.classDate = classDate
            self.classLocation = classLocation
            self.classDuration = classDuration
            self.classType = classType
            self.classLevel = classLevel
            self.classMaxSize = classMaxSize
        }
    }

    func createClass(with newClass: ExampleClassType) {
        exampleClass.append(newClass)
    }

    func updateClass(with updatedClass: ExampleClassType, newName: String, newDate: Date, newLocation: String ) {
        var editClass = updatedClass
        editClass.className = newName
        editClass.classDate = newDate
        editClass.classLocation = newLocation
        exampleClass.append(editClass)
        deletedClasses(with: updatedClass)
    }

    func deletedClasses(with oldClass: ExampleClassType) {
        if exampleClass.contains(oldClass) {
            exampleClass.removeAll{ $0 == oldClass}
        }
    }
}
