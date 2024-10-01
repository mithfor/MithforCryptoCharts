//
//  AssetsViewControllerTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 01.10.2024.
//

import XCTest
@testable import MithforCryptoCharts

final class AssetsViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initWithCoder() throws {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let sut = AssetsViewController(coder: archiver)
        XCTAssertNil(sut)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
