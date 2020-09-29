import XCTest
@testable import Social_App

class Social_AppTests: XCTestCase {

    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
        print("teardown!")
    }
    
    func testGenesisUsername() {
        //NOTE: UUID of genesis user, PJ G.
        let uuid = "xZpxFZD2kIg4j61ioqDprrnK5cu1"
        fetchUser(uid: uuid) { (fetchedUser) in
            XCTAssert(fetchedUser.username == "PJ G.")
        }
    }

}
