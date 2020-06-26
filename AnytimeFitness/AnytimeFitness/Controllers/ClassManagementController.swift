//
//  ClassManagementController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/25/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation
import CoreData
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

class ClassManagementController {

}
