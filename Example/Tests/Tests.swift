import UIKit
import XCTest
import GRMCommonTools

class Tests: XCTestCase {

    var view:UIView!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        view = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))

        //let controller = UIViewController()
        //controller.view = UIView(frame: UIScreen.main.bounds)
        //controller.view.addSubview(view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }

    func testAngle() {
        let angle:Int = -45
        view.rotateView(degrees: -45)
        let viewAngle:Int = Int(view.angle)
        XCTAssertEqual(angle, viewAngle)
        print("Angle: \(viewAngle)˚")

    }
    
}
