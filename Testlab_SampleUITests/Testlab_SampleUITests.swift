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
        
        //Checks that Count displays & is intilialized as zero
        XCTAssertTrue(countLabel.exists)
        XCTAssertEqual(countLabel.label, "Count: 0")
        
        //Checks that Increment button works as expected
        incrementButton.tap()
        
        let newCount = app.staticTexts["countLabel"]
        XCTAssertEqual(newCount.label, "Count: 1")
        
        //Checks Reset button works as expected
        resetButton.tap()
        
        let finalCount = app.staticTexts["countLabel"]
        XCTAssertEqual(finalCount.label, "Count: 0")
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
