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
    
    func test_initInteractor_NotNill() {
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        
        let sut = AssetsConfigurator.configured(AssetsViewController(viewModel: AssetListViewModel(router: router)))
        
        
        XCTAssertNotNil(sut.interactor)
    }
    
    func test_SetUpTableDataSource() {
        let sut = Helper.shared.makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.assetsTableView.dataSource)
    }
    
    func test_SetUpTableDelegate() {
        let sut = Helper.shared.makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.assetsTableView.delegate)
    }
    
    func test_clearSearchBarText_WhenPullingToRefresh() {
        let sut = Helper.shared.makeSUT()
        
        let expectedSearchBarText = ""
        
        sut.handleRefreshControl()
        
        XCTAssertEqual(sut.searchController.searchBar.text, expectedSearchBarText)
    }
    
    func test_EndRefreshing_RefreshControlIsNil() {
        let sut = Helper.shared.makeSUT()
        
        sut.handleRefreshControl()
        
        XCTAssertNil(sut.assetsTableView.refreshControl)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// Helpers

fileprivate class Helper {
    static let shared = Helper()
    
    private init() {
        
    }
    
    func makeSUT() -> AssetsViewController {
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        
        let sut = AssetsConfigurator.configured(AssetsViewController(viewModel: AssetListViewModel(router: router)))
        
        sut.interactor = AssetInteractorStub()
        
        return sut
    }
}

final class AssetInteractorStub: AssetsViewControllerOutput {
    func fetchAssets() {
        
    }
    
    func fetchImage(for asset: MithforCryptoCharts.Asset, completion: @escaping (() -> Void)) {
        
    }
}
