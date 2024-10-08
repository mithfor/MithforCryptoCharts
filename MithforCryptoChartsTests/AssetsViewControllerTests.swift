//
//  CryptoAssetsViewControllerTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 01.10.2024.
//

import XCTest
@testable import MithforCryptoCharts

final class CryptoAssetsViewControllerTests: XCTestCase {

    var sut: CryptoAssetsViewController?
    
    override func setUpWithError() throws {
        sut = Helper.shared.makeSUT()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_initWithCoder() throws {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let sut = CryptoAssetsViewController(coder: archiver)
        XCTAssertNil(sut)
    }
    
    func test_initInteractor_NotNill() {
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        
        let sut = CryptoAssetsConfigurator.configured(CryptoAssetsViewController(viewModel: AssetListViewModel(router: router)))
        
        
        XCTAssertNotNil(sut.interactor)
    }
    
    
    
    func test_clearSearchBarText_WhenPullingToRefresh() {
        
        let expectedSearchBarText = ""
        
        sut!.handleRefreshControl()
        
        XCTAssertEqual(sut!.searchController.searchBar.text, expectedSearchBarText)
    }
//    
//    func test_EndRefreshing_RefreshControlIsNil() {
//        let sut = Helper.shared.makeSUT()
//                
//        sut.handleRefreshControl()
//        
//        XCTAssertNil(sut.assetsTableView.refreshControl)
//    }
    
    func test_CryptoAssetsTableViewDelegates_ShouldBeSet() {
                
        XCTAssertNotNil(sut!.assetsTableView.delegate, "assetsTableView.delegate")
        XCTAssertNotNil(sut!.assetsTableView.dataSource, "assetsTableView.dataSource")
    }
    
    func test_AssetTableViewNumberOfSection_ShouldBe1() {
        
        XCTAssertEqual(sut!.assetsTableView.numberOfSections, 1)
    }
    
    func test_CryptoAssetsTableViewNumberOfRowsInSection1_ShouldBe0() {
        XCTAssertEqual(sut?.assetsTableView.dataSource?.tableView(sut!.assetsTableView, 
                                                                  numberOfRowsInSection: 0), 0)
    }
    
//    func test_CryptoAssetsTableViewBackgroundColor_ShouldBeMainbackground() {
//        XCTAssertEqual(sut!.assetsTableView.backgroundColor, .systemRed)
//    }
    
    
}

// Helpers

fileprivate class Helper {
    static let shared = Helper()
    
    private init() {
        
    }
    
    func makeSUT() -> CryptoAssetsViewController {
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let sut = CryptoAssetsConfigurator.configured(CryptoAssetsViewController(viewModel: AssetListViewModel(router: router)))
        
        sut.interactor = AssetInteractorStub()
        sut.loadViewIfNeeded()
        
        return sut
    }
}

final class AssetInteractorStub: CryptoAssetsViewControllerOutput {
    func fetchCryptoAssets() {
        
    }
    
    func fetchImage(for asset: MithforCryptoCharts.CryptoAsset, completion: @escaping (() -> Void)) {
        
    }
}
