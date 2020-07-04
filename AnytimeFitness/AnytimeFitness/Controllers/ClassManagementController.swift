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
extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

class ClassManagementController {

    func formatClassTime(with newClass: NewClass) -> String {
        let timeString = newClass.classDateCD
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: timeString)
    }

    func formatClassDate(with newClass: NewClass) -> String {
        let dateString = newClass.classDateCD
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d, yyyy"
        return formatter.string(from: dateString)
    }


    func updateInstructorClass(with newClass: NewClass, name: String, address: String, newDate: Date) {
        newClass.classNameCD = name
        newClass.classLocationCD = address
        newClass.classDateCD = newDate
        NetworkController.sharedNetworkController.updateClass(for: newClass) { (error) in
            if let error = error {
                print("Error for updating Instructor class: \(error)")
            }
        }
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("Error saving managed object context: \(error)")
        }
    }

    func updateClassCount(with newClass: NewClass) {
        if newClass.classMaxSizeCD == newClass.classCurrentSizeCD {
            return
        }
        newClass.classCurrentSizeCD += 1
        NetworkController.sharedNetworkController.updateClass(for: newClass) { (error) in
            if let error = error {
                print("Error for adding Instructor class count: \(error)")
            }
        }
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("Error saving managed object context: \(error)")
        }
    }

    func deleteClassCount(with newClass: NewClass) {
        if newClass.classCurrentSizeCD < 1 {
            return
        } else {
            newClass.classCurrentSizeCD -= 1
        }
        NetworkController.sharedNetworkController.updateClass(for: newClass) { (error) in
            if let error = error {
                print("Error for subtracting Instructor class count: \(error)")
            }
        }
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("Error saving managed object context: \(error)")
        }
    }

    func createClientClass(with newClass: NewClass) {
        let currentClient = NetworkController.sharedNetworkController.currentCDClient
        guard let currentClients = currentClient else {
            return
        }
        newClass.addToRegisteredClients(currentClients)
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("Error saving client to the class: \(error)")
        }
    }

    func deleteClientClass(with newClass: NewClass) {
        let currentClient = NetworkController.sharedNetworkController.currentCDClient
        guard let currentClients = currentClient else {
            return
        }
        newClass.removeFromRegisteredClients(currentClients)
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("Error deleting client from the class: \(error)")
        }
    }

}
