//
//  AssetDetailsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import UIKit
import SwiftUI

protocol AssetDetailsViewControllerInput: AnyObject {
    func updateHistory(with assetHistory: [AssetHistory])
    func updateFailed(with error: NetworkError)
}

protocol AssetDetailsViewControllerOutput: AnyObject {
    func fetchHistory(asset: Asset)
}

final class AssetDetailsViewController: UIViewController {
    
    // MARK: - Private vars
    private let asset: Asset
    private let watchList = WatchList()
    
    var interactor: AssetDetailsInteractorInput?
    
    private var assetDetailsView: AssetDetailsView = {
        let view = AssetDetailsView()
        
        return view
    }()
    
    // MARK: - INIT
    init(viewModel: AssetDetailsViewModel) {
        
        self.asset = viewModel.asset

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OVERRIDEN METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureRefreshControl()
        
        interactor?.fetchHistory(asset: asset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateUI()
        setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        assetDetailsView.pinToEdges(of: view)
    }
    
    func configureRefreshControl() {
        assetDetailsView.scrollView.refreshControl = UIRefreshControl()
        assetDetailsView.scrollView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        
        interactor?.fetchHistory(asset: asset)

        CFRunLoopPerformBlock(CFRunLoopGetMain(),
                              CFRunLoopMode.commonModes.rawValue) {
            self.assetDetailsView.scrollView.refreshControl?.endRefreshing()
       }
    }
    
    // MARK: - SETUP
    private func configureUI() {
        view.backgroundColor = ColorConstants.mainBackground
        
        configureNavigation()
    
        view.addSubview(assetDetailsView)
    }
    
    private func configureNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    // MARK: UPDATES
    private func updateUI() {
                
        updateTitle(with: asset.name ?? "Default Name", and: asset.symbol ?? "Default Symbol")
        
        updateWatchList()
        
        updateDetailsView()
    }
    
    private func updateDetailsView() {
        assetDetailsView.updateAssetPriceUSD(with: "$\(String.formatToCurrency(string: asset.priceUsd ?? "No data"))", and: ColorConstants.Asset.symbol)
        assetDetailsView.updateAssetChangePercent24Hr(with: asset.changePercent24Hr ?? "No data")
        assetDetailsView.updateLine1(with: "$\(String.formatToCurrency(string: asset.marketCapUsd ?? "No data"))")
        assetDetailsView.updateLine2(with: "$\(String.formatToCurrency(string: asset.supply ?? "No data"))")
        assetDetailsView.updateLine3(with: "$\(String.formatToCurrency(string: asset.volumeUsd24Hr ?? "No data"))")
    }
    
    private func updateWatchList() {
        
        watchList.load()
        
        let imageName = watchList.contains(asset) == false ? Constants.Icon.watchlist : Constants.IconFill.watchlist
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: self, action: #selector(didTapAddToWatchList))
    }
    
    // MARK: - ACTIONS
    // TODO: - move logic to interactor (if it is allready in)
    @objc func didTapAddToWatchList() {
        
        var imageName = ""
        if watchList.contains(asset) {
            imageName = Constants.Icon.watchlist
            watchList.remove(asset)
           
        } else {
            imageName = Constants.IconFill.watchlist
            watchList.add(asset)
        }

        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
}

extension UIViewController {

    func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.3) {
        if animated {
            if let frame = self.tabBarController?.tabBar.frame {
                let factor: CGFloat = hidden ? 1 : -1
                let y = frame.origin.y + (frame.size.height * factor)
                UIView.animate(withDuration: duration, animations: {
                    self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
                })
                return
            }
        }
        self.tabBarController?.tabBar.isHidden = hidden
    }

}

// MARK: - AssetDetailsViewControllerInput
extension AssetDetailsViewController: AssetDetailsViewControllerInput {
    func updateHistory(with assetHistory: [AssetHistory]) {
        
            self.assetDetailsView.updateHistoryChart(with: assetHistory)
    }
    
    func updateTitle(with name: String, and symbol: String) {
        
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: name, attributes: [
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: AppConstants.navigationItemTextSize),
                                                    NSAttributedString.Key.foregroundColor: ColorConstants.Asset.symbol])
        navTitle.append(NSMutableAttributedString(string: " "))
        navTitle.append(NSMutableAttributedString(string: symbol, attributes: [
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: AppConstants.navigationItemTextSize),
                                                    NSAttributedString.Key.foregroundColor: ColorConstants.Asset.name]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    
    func updateFailed(with error: NetworkError) {
        print(#function)
        presentAlertOnMainThread(title: NetworkError.networkError.rawValue.lowercased(),
                                 message: error.rawValue,
                                 buttonTitle: Constants.Common.ok)
    }
}

// MARK: - AssetDetailsViewModel
final class AssetDetailsViewModel {
    typealias Routes = AssetDetailsRoute
    private var router: Routes
    
    var asset: Asset
    
    init(router: Routes, asset: Asset) {
        self.router = router
        self.asset = asset
    }
    
    func watchListTapped(asset: Asset) {
        print(#function)
    }
}
