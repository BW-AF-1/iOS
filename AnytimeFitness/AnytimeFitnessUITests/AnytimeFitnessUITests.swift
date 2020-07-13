//
//  AnytimeFitnessUITests.swift
//  AnytimeFitnessUITests
//
//  Created by Jarren Campos on 7/13/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import XCTest

class AnytimeFitnessUITests: XCTestCase {
    
    func testValidClientLoginSuccess() {
        let validInstructorEmail = "p@p.com"
        let validInstructorPassword = "password"
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Client Sign In"].tap()
        
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText(validInstructorEmail)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(validInstructorPassword)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        app.buttons["Confirm"].tap()
        
        
    }
    
    func testValidInstructorLoginSuccess() {
        let validInstructorEmail = "t@t.com"
        let validInstructorPassword = "password"
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Instructor Sign In"].tap()
        
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText(validInstructorEmail)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(validInstructorPassword)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        app.buttons["Sign In"].tap()
        
        
        
    }
}
