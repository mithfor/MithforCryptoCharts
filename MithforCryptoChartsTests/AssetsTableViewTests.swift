//
//  CryptoAssetsTableViewTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 02.10.2024.
//

import XCTest
@testable import MithforCryptoCharts

final class CryptoAssetsTableViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_InitWiithCoder() {
        let coder = NSKeyedArchiver(requiringSecureCoding: true)
        let sut = CryptoAssetsTableView(coder: coder)
        XCTAssertNil(sut)
    }

    func test_InitWithDefaultState() {
        let sut = CryptoAssetsTableView()
        
        XCTAssertEqual(sut.state, .initiate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
