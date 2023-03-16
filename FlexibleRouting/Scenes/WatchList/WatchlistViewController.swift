//
//  WatchListViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

//MARK: - WatchListViewControllerInput
protocol WatchListViewControllerInput: AnyObject, ResultError {
    
    func update(_ assets: Assets)
}

//MARK: - WatchListViewControllerOutput
protocol WatchListViewControllerOutput: AnyObject {
    func fetchFavoriteAssets(watchList: WatchList)
    func fetchAssetDetails(by id: String, completion: @escaping (AssetResponse) -> ())
}

//MARK: - WatchListViewController
class WatchlistViewController: UIViewController {
    
    private var viewModel: WatchlistViewModel?
    
    var interactor: WatchListInteractorInput?
    
    //MARK: - VARIABLES
    var watchlist = WatchList()
    var assets = Assets()
    
    private lazy var assetsTableView: AssetsTableView = {
        let tableView = AssetsTableView()
        tableView.register(AssetsTableViewCell.self, forCellReuseIdentifier: AssetsTableViewCell.identifier)
                
        return tableView
    }()
    
    //MARK: - Init
    init(viewModel: WatchlistViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- OVERRIDEN METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        fetchFavoriteAssets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchFavoriteAssets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        assetsTableView.pinToEdges(of: view)
    }
    
    // MARK: - SETUP
    private func setupAssetsTableViewConstraints() {
        view.addSubview(assetsTableView)
        assetsTableView.pinToEdges(of: view)
    }
    
    private func setupUI() {
        
        self.title = Constants.Strings.Title.watchlist
        
        assetsTableView.dataSource = self
        assetsTableView.delegate = self
        
        configureRefreshControl()
        
        setupAssetsTableViewConstraints()
        
        setupNavigationItem()
        
    }
    
    func configureRefreshControl () {
        self.assetsTableView.refreshControl = UIRefreshControl()
        self.assetsTableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        
        fetchFavoriteAssets()

        CFRunLoopPerformBlock(CFRunLoopGetMain(),
                              CFRunLoopMode.defaultMode.rawValue) {
              
            self.assetsTableView.refreshControl?.endRefreshing()
        }
    }
    
    private func fetchFavoriteAssets() {
        interactor?.fetchFavoriteAssets(watchList: watchlist)
    }
    
    fileprivate func setupNavigationItem() {
        let backItem = UIBarButtonItem()
        backItem.title = Constants.Strings.Title.watchlist
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier, for: indexPath) as? AssetsTableViewCell {
            cell.configureWith(delegate: nil, and: assets[indexPath.row], image: UIImage(systemName: "house"))
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
        
        //TODO: - Localize it!
        return Constants.Strings.Common.remove
    }
}


//MARK: - WatchlistViewControllerInput
extension WatchlistViewController: WatchListViewControllerInput {
    func update(_ assets: Assets) {
        self.assets = assets
        assetsTableView.reloadData()
    }
    
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: Constants.Strings.Common.error,
                                 message: error.rawValue,
                                 buttonTitle: Constants.Strings.Common.ok)
    }
}

extension WatchlistViewController: AssetsTableViewCellDelegate {
    func viewDetails(_ asset: Asset) {
        viewModel?.assetDetailsTapped(asset: asset)
    }
    
    
}

//MARK: - WatchlistViewModel
final class WatchlistViewModel {
    typealias Routes = AssetDetailsRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func assetDetailsTapped(asset: Asset) {
        router.openAssetDetails(asset)
    }
}
