//
//  MainTabBarContollerTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 25.09.2024.
//

import XCTest
@testable import MithforCryptoCharts

final class MainTabBarControllerTests: XCTestCase {

    func test_shouldInitiate_withZeroControllers() throws {

        let sut = makeSUT()

        XCTAssertNil(sut.viewControllers)
    }
    
    func test_shouldInitiate_withControllersCount_EqualsTabsCount() throws {

        let controllers = [UIViewController(),
                           UIViewController(),
                           UIViewController()]
        let sut = makeSUT(with: controllers)

        XCTAssertEqual(sut.viewControllers?.count, MainTabs.allCases.count)
    }
    
    func test_tabsCount_equalsThree() {
        
        XCTAssertEqual(MainTabs.allCases.count, 3)
    }
    
    func test_setupTabBarItem_AssetsTagIsCorrect() {
        let tab = MainTabs.assets
        let item = tab.item
        
        XCTAssertEqual(item.tag, 0)
    }
    
    func test_setupTabBarItem_WhatchListTagIsCorrect() {
        let tab = MainTabs.watchlist
        let item = tab.item
        
        XCTAssertEqual(item.tag, 1)
    }
    
    func test_setupTabBarItem_SettingsTagIsCorrect() {
        let tab = MainTabs.settings
        let item = tab.item
        
        XCTAssertEqual(item.tag, 2)
    }
    
    func test_setTabBar_tintColorGreen() throws {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.tabBar.tintColor, UIColor.systemBlue)
    }

}

// Helpers
func makeSUT(with controllers: [UIViewController] = []) -> MainTabBarController {
    let sut = MainTabBarController(viewControllers: controllers)
    return sut
}
