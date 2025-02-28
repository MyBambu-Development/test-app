//
//  Testlab_SampleUITests.swift
//  Testlab_SampleUITests
//
//  Created by Chase Moffat on 2/19/25.
//

import XCTest

final class Testlab_SampleUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testIncrementButton() throws {
        let countLabel = app.staticTexts["countLabel"]
        let incrementButton = app.buttons["incrementButton"]
        let resetButton = app.buttons["resetButton"]
        
        // ✅ Step 1: Check if user is already signed in
        if countLabel.exists {
            print("User is already signed in. Skipping login.")
        } else {
            print("User is not signed in. Performing login flow.")

            let welcomeLogin = app.buttons["welcomeLogin"]
            XCTAssertTrue(welcomeLogin.exists, "Login button does not exist")
            welcomeLogin.tap()
            
            let emailField = app.textFields["emailLoginTextField"]
            let passwordField = app.secureTextFields["passwordLoginTextField"]
            let signInButton = app.buttons["signInButton"]
            
            XCTAssertTrue(emailField.exists, "Email field is missing")
            emailField.tap()
            emailField.typeText("chase11@fake.com")
            
            XCTAssertTrue(passwordField.exists, "Password field is missing")
            passwordField.tap()
            passwordField.typeText("Test@123")
            
            XCTAssertTrue(signInButton.exists, "Sign In button does not exist")
            signInButton.tap()
            
            // ✅ Step 2: Wait for the home screen (countLabel) to appear
            XCTAssertTrue(countLabel.waitForExistence(timeout: 5), "Count label did not appear")
        }
        
        // ✅ Step 3: Continue with counter test
        XCTAssertEqual(countLabel.label, "Count: 0", "Initial count is incorrect")
        
        // Increment count
        incrementButton.tap()
        XCTAssertEqual(countLabel.label, "Count: 1", "Increment did not work")
        
        // Reset count
        resetButton.tap()
        XCTAssertEqual(countLabel.label, "Count: 0", "Reset did not work")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
