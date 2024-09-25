//
//  MainTabBarContollerTests.swift
//  FlexibleRoutingTests
//
//  Created by Dmitrii Voronin on 25.09.2024.
//

import XCTest
@testable import FlexibleRouting

final class MainTabBarControllerTests: XCTestCase {

    func test_shouldInitiate_withZeroControllers() throws {

        let sut = makeSUT()

        XCTAssertNil(sut.viewControllers)
    }
    
    func test_shouldInitiate_withControllers() throws {

        let controllers = [UIViewController()]
        let sut = makeSUT(with: controllers)

        XCTAssertEqual(sut.viewControllers?.count, controllers.count)
    }
    
    func test_tabsCount_equalsThree() {
        
        XCTAssertEqual(Tabs.allCases.count, 3)
    }
    
    func test_setupTabBarItem_AssetsTagIsCorrect() {
        let tab = Tabs.assets
        let item = tab.item
        
        XCTAssertEqual(item.tag, 0)
    }
    
    func test_setupTabBarItem_WhatchListTagIsCorrect() {
        let tab = Tabs.watchlist
        let item = tab.item
        
        XCTAssertEqual(item.tag, 1)
    }
    
    func test_setupTabBarItem_SettingsTagIsCorrect() {
        let tab = Tabs.settings
        let item = tab.item
        
        XCTAssertEqual(item.tag, 2)
    }
    
    func test_setTabBar_tintColorGreen() throws {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.tabBar.tintColor, UIColor.systemGreen)
    }

}

// Helpers
func makeSUT(with controllers: [UIViewController] = []) -> MainTabBarController {
    let sut = MainTabBarController(viewControllers: controllers)
    return sut
}
