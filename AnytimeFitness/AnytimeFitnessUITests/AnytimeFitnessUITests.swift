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
        let app = XCUIApplication()
        app.launch()
        
        loginUser(userType: "Client Sign In", username: "p@p.com", password: "password", app: app)
        
        
    }
    
    func testValidInstructorLoginSuccess() {
        
        let app = XCUIApplication()
        app.launch()
        
        loginUser(userType: "Instructor Sign In", username: "t@t.com", password: "password", app: app)
    }
    
    func testClientAppWalkthrough() {
        
        let app = XCUIApplication()
        app.launch()
        
        loginUser(userType: "Client Sign In", username: "p@p.com", password: "password", app: app)
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Search"].twoFingerTap()
        tabBarsQuery.buttons["Account"].twoFingerTap()
        
        let signOutButton = app.buttons["Sign Out"]
        signOutButton.twoFingerTap()
    }
    
    func testInstructorAppWalkthrough() {
        let app = XCUIApplication()
        app.launch()
        
        loginUser(userType: "Instructor Sign In", username: "t@t.com", password: "password", app: app)
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Create"].twoFingerTap()
        tabBarsQuery.buttons["Profile"].twoFingerTap()
        let signOutButton = app.buttons["Sign Out"]
        signOutButton.twoFingerTap()
        
    }
    
    func loginUser(userType: String, username: String, password: String, app: XCUIApplication){
            app.buttons[userType].tap()
            
            app.textFields["Email"].tap()
            app.textFields["Email"].typeText(username)
        
            app.buttons["Return"].tap()

            let passwordSecureTextField = app.secureTextFields["Password"]
            passwordSecureTextField.tap()
            passwordSecureTextField.typeText(password)
            
            app.buttons["Return"].tap()

            app.buttons["Sign In"].tap()
            return
    }
}
