//
//  InstructorCreateClassController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/24/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewSelectable {

}

struct CreateClassType {
    var classDuration: Int
    var classType: String
    var classLevel: String
    var classMaxSize: Int
}

struct CreateClassName {
    var className: String
    var classDate: Date
    var classLocation: String
}

enum ClassLevelInt: Int, TableViewSelectable, Codable {
    case beginner, intermediate, advanced
    static let allClassLevelKeys = [beginner, intermediate, advanced]
    static let allClassLevelNames = [beginner.getName, intermediate.getName, advanced.getName]
    var getName: String {
        switch self {
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .advanced:
            return "Advanced"
        }
    }
}


enum ClassTypeInt: Int, TableViewSelectable, Codable {
    case boxing, dancing, biking, pilates, running, stretch, weightlifting, yoga, bootcamp, cardio, functionalFitness, ect
    static let allFitnessTypeKeys = [boxing, dancing, biking, pilates, running, stretch, weightlifting, yoga, bootcamp, cardio, functionalFitness, ect]
    static let allFitnessTypeNames = [boxing.getName, dancing.getName, biking.getName, pilates.getName, running.getName, stretch.getName, weightlifting.getName, yoga.getName, bootcamp.getName, cardio.getName, functionalFitness.getName, ect.getName]
    var getName: String {
        switch self {
        case .boxing:
            return "Boxing"
        case .dancing:
            return "Dancing"
        case .biking:
            return "Dancing"
        case .pilates:
            return "Pilates"
        case .running:
            return "Running"
        case .stretch:
            return "Stretch"
        case .weightlifting:
            return "Weightlifting"
        case .yoga:
            return "Yoga"
        case .bootcamp:
            return "Bootcamp"
        case .cardio:
            return "Cardio"
        case .functionalFitness:
            return "Functional Fitness"
        case .ect:
            return "Ect."
        }
    }

}

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
