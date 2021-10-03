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
        VisionrangerAPI.defaultAccessKey = "pm5I7eUkgw3T3WBK5LkRb3nAGFAWV6cC2r7dV1uA"
        client = VSNAPIClient.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssertEqual(VSNConfigurationDeliveryRange.threeToFiveDays.rawValue, 0)
    }
    
    func testGetProduct() throws {
        
        client.retrieveProduct(id: "1") { product, error in
            XCTAssertNil(error, "Unexpected error occured")
        }
    }
}
