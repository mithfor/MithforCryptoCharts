//
//  WatchListViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

// MARK: - WatchListViewControllerInput
protocol WatchListViewControllerInput: AnyObject, ResultError {
    func update(_ assets: CryptoAssets)
}

// MARK: - WatchListViewControllerOutput
protocol WatchListViewControllerOutput: AnyObject {
    func fetchFavoriteCryptoAssets(watchList: WatchList)
    func fetchAssetDetails(by id: String, completion: @escaping (CryptoAssetResponse) -> Void)
}

// MARK: - WatchListViewController
class WatchlistViewController: UIViewController {
    private var viewModel: WatchlistViewModel?
    var interactor: WatchListInteractorInput?
    // MARK: - VARIABLES
    var watchlist = WatchList()
    var assets = CryptoAssets()
    
    private lazy var assetsTableView: CryptoAssetsTableView = {
        let tableView = CryptoAssetsTableView()
        tableView.register(CryptoAssetsTableViewCell.self, forCellReuseIdentifier: CryptoAssetsTableViewCell.identifier)
                
        return tableView
    }()
    
    // MARK: - Init
    init(viewModel: WatchlistViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OVERRIDEN METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        fetchFavoriteCryptoAssets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupUI()
        
        fetchFavoriteCryptoAssets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        assetsTableView.pinToEdges(of: view)
    }
    
    // MARK: - SETUP
    private func setupCryptoAssetsTableViewConstraints() {
        view.addSubview(assetsTableView)
        assetsTableView.pinToEdges(of: view)
    }
    
    private func setupUI() {
        
        self.title = Constants.Title.watchlist
        
        assetsTableView.dataSource = self
        assetsTableView.delegate = self
        
        configureRefreshControl()
        
        setupCryptoAssetsTableViewConstraints()
        
        setupNavigationItem()
        
    }
    
    func configureRefreshControl () {
        self.assetsTableView.refreshControl = UIRefreshControl()
        self.assetsTableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        
        fetchFavoriteCryptoAssets()

        CFRunLoopPerformBlock(CFRunLoopGetMain(),
                              CFRunLoopMode.defaultMode.rawValue) {
              
            self.assetsTableView.refreshControl?.endRefreshing()
        }
    }
    
    private func fetchFavoriteCryptoAssets() {
        interactor?.fetchFavoriteCryptoAssets(watchList: watchlist)
    }
    
    fileprivate func setupNavigationItem() {
        let backItem = UIBarButtonItem()
        backItem.title = Constants.Title.watchlist
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
}

// MARK: - UITableViewDataSource
extension WatchlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlist.assetsIds.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !assets.isEmpty else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: CryptoAssetsTableViewCell.identifier, 
                                                    for: indexPath) as? CryptoAssetsTableViewCell {
            let asset = assets[indexPath.row]
            cell.configureWith(delegate: nil,
                               and: asset,
                               image: UIImage(named: asset.symbol?.lowercased() ?? "ok".lowercased()) ?? UIImage())
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            watchlist.remove(assets.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension WatchlistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        // TODO: - Localize it!
        return Constants.Common.remove
    }
}

// MARK: - WatchlistViewControllerInput
extension WatchlistViewController: WatchListViewControllerInput {
    func update(_ assets: CryptoAssets) {
        self.assets = assets
        DispatchQueue.main.async {
            self.assetsTableView.reloadData()
        }
    }
    
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: Constants.Common.error,
                                 message: error.rawValue,
                                 buttonTitle: Constants.Common.ok)
    }
}

extension WatchlistViewController: CryptoAssetsTableViewCellDelegate {
    func viewDetails(_ asset: CryptoAsset) {
        viewModel?.assetDetailsTapped(asset: asset)
    }
}

// MARK: - WatchlistViewModel
final class WatchlistViewModel {
    typealias Routes = AssetDetailsRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func assetDetailsTapped(asset: CryptoAsset) {
        router.openAssetDetails(asset)
    }
}
