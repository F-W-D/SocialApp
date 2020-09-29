import XCTest

class Social_AppUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    //NOTE: This test only works if User not logged in.
    func testUserLogin() {
        
        let app = XCUIApplication()
        app.textFields["+1-385-439-4920"].tap()
        app.textFields["+1-385-439-4920"].typeText("1 801635-0389")
        app.buttons["Verify"].tap()
    
        let verifyTextfield = app.alerts["Message"].scrollViews.otherElements.collectionViews.textFields["123456"]
        XCTAssert(verifyTextfield.waitForExistence(timeout: 45.0))
        verifyTextfield.tap()
        verifyTextfield.typeText("123456")
        app.alerts["Message"].scrollViews.otherElements.buttons["Verify"].tap()
        
        let title = app.staticTexts["Posts"]
        XCTAssert(title.waitForExistence(timeout: 25.0))
    }
 
    override func tearDown() {
        super.tearDown()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
