//
//  VisionrangerTests.swift
//  VisionrangerTests
//
//  Created by Colin Tessarzick on 21.09.21.
//

import XCTest
@testable import Visionranger

class VisionrangerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssertEqual(VSNConfigurationDeliveryRange.threeToFiveDays.rawValue, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
