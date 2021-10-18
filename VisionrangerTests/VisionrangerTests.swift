//
//  VisionrangerTests.swift
//  VisionrangerTests
//
//  Created by Colin Tessarzick on 21.09.21.
//

import XCTest
@testable import Visionranger

class VisionrangerTests: XCTestCase {
    
    var client: VSNAPIClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        VisionrangerAPI.defaultAccessKey = ""
        client = VSNAPIClient.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssertEqual(VSNEstimatedDelivery.threeToFiveDays.rawValue, 0)
    }
}
