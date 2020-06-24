//
//  ExampleClassType.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/23/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation

struct ExampleClassType: Equatable, Codable {
    var className: String
    var classTime: String
    var classDate: String
    var classDescription: String
    var classPrice: String
    var classLocation: String
    var classNeedToKnow: String
    var classDuration: Int
    var classType: String
    var classLevel: String
    var classSize: Int

    init(className: String = "Example Class", classTime: String = "4 pm", classDate: String = "Thursday, June 4", classDescription: String = "Example Class Description", classPrice: String = "$10", classLocation: String = "Boston, MA", classNeedToKnow: String = "Example need to know", classDuration: Int = 10, classType: String = "Cardio", classLevel: String = "Easy", classSize: Int = 20) {
        self.className = className
        self.classTime  = classTime
        self.classDate = classDate
        self.classDescription = classDescription
        self.classPrice = classPrice
        self.classLocation = classLocation
        self.classNeedToKnow = classNeedToKnow
        self.classDuration = classDuration
        self.classType = classType
        self.classLevel = classLevel
        self.classSize = classSize
    }
}
