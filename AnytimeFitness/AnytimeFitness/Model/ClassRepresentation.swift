//
//  ClassRepresentation.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/28/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation

struct ClassRepresentation: Equatable, Codable {
   var classIdentifierCD: UUID?
   var classID: Int?
   var classDateCD: String
   var classDurationCD: String
   var classLevelCD: String
   var classLocationCD: String
   var classMaxSizeCD: Int
   var classCurrentSizeCD: Int
   var classNameCD: String
   var classTypeCD: String
   var instructorID: Int


    enum CodingKeys: String, CodingKey {
        case classIdentifierCD
        case classID = "id"
        case classDateCD = "startTime"
        case classDurationCD = "duration"
        case classLevelCD = "intensityLevel"
        case classLocationCD = "location"
        case classMaxSizeCD = "maxClassSize"
        case classCurrentSizeCD = "attendees"
        case classNameCD = "name"
        case classTypeCD = "type"
        case instructorID = "instructor_id"
    }
}

struct InstructorRepresentation: Equatable, Codable {

    var email: String
    var password: String
    var instructorID: Int?

    enum CodingKeys: String, CodingKey {
        case email = "username"
        case password
        case instructorID = "id"
    }
}

struct ClientRepresentation: Equatable, Codable {
    var email: String
    var password: String
    var clientID: Int?

    enum CodingKeys: String, CodingKey {
        case email = "username"
        case password
        case clientID = "id"
    }
}

