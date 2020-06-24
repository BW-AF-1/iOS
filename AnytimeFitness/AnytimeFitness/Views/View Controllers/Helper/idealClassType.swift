//
//  idealClassType.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/23/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation

struct SampleInstructor {
    var name: String
    var password: String
    var id: String
}

struct SampleClient {
    var name: String
    var password: String
    var id: String
}

struct ClassSchedule {
    var classDate: Date
    var classTime: [String]
}

enum ClassType: String {
    case boxing = "Boxing"
    case dancing = "Dancing"
    case biking = "Biking"
    case pilates = "Pilates"
    case running = "Running"
    case stretch = "Stretch"
    case weightlifting = "Weightlifting"
    case yoga = "Yoga"
    case bootcamp = "Bootcamp"
    case cardio = "Cardo"
    case functionalFitness = "Functional Fitness"
    case ect = "Ect."
}

enum ClassLevel: String {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}

enum ClassSizeCategory: String {
    case small = "Small (1-5)"
    case medium = "Medium (5-15)"
    case large = "Large (16+)"
}

enum ClassDurationCategory: String {
    case short = "Short (less than 30 min)"
    case average = "Average (30 - 45 min)"
    case long = "Long (more than 45 min)"
}

struct IdealClassType {
    var className: String
    var classSchedule: [ClassSchedule]
    var classDescription: String?
    var classPrice: String
    var classLocation: String
    var classNeedToKnow: String?
    var classDuration: Int
    var classType: ClassType
    var classLevel: ClassLevel
    var classMaxSize: Int
    var classInstructor: SampleInstructor
    var classAttendees: [SampleClient]?
}

struct AllIdealClasses {
    var allIdealClasses: [IdealClassType]
}
