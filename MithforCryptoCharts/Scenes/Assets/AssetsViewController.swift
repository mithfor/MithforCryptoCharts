//
//  CryptoAssetsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

typealias AssetId = String
typealias AssetImage = UIImage

typealias AssetModel = [AssetId: AssetImage]

protocol ResultError {
    func updateFailed(with error: NetworkError)
}

protocol CryptoAssetsViewControllerInput: AnyObject, ResultError {
    func update(_ assets: CryptoAssets)
}

protocol CryptoAssetsViewControllerOutput: AnyObject {
    func fetchCryptoAssets()
    func fetchImage(for asset: CryptoAsset, completion: @escaping (() -> Void))
}

enum SearchActionState {
    case active
    case inactive
}

// TODO: - Fix AssetWithImage to AssetViewModel!!!
struct AssetViewModel {
    let asset: CryptoAsset
    let image: UIImage
}

// MARK: - CryptoAssetsViewController
class CryptoAssetsViewController: UIViewController {
    
    private var viewModel: AssetListViewModel?
    
    // TODO: - remove optional if needed
    var interactor: CryptoAssetsViewControllerOutput?
    
    private var assetViewModels: [AssetViewModel] = []
    
    private var assets: CryptoAssets?
    private var filteredCryptoAssets: CryptoAssets = []
    private var assetModel: AssetModel = [:]
    private var searching: SearchActionState = .inactive
        
    lazy var assetsTableView: CryptoAssetsTableView = {
        let tableView = CryptoAssetsTableView()
        tableView.register(CryptoAssetsTableViewCell.self,
                           forCellReuseIdentifier: CryptoAssetsTableViewCell.identifier)
        
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()

    // MARK: - Init
    init(viewModel: AssetListViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Overriden
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        self.showSpinnner()
        interactor?.fetchCryptoAssets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        assetsTableView.pinToEdges(of: view)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        
        self.title = Constants.Title.assets
        
        assetsTableView.dataSource = self
        assetsTableView.delegate = self
        
        self.assetsTableView.backgroundColor = ColorConstants.mainBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = searchController

        addSubviews()
        configureRefreshControl()
    }
    
    private func addSubviews() {
        view.addSubview(assetsTableView)
    }
    
    func configureRefreshControl () {
        self.assetsTableView.refreshControl = UIRefreshControl()
        self.assetsTableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        
        interactor?.fetchCryptoAssets()
        
        self.searchController.searchBar.text = ""
        
        // TODO: - how to test is endRefreshing?
        if let refreshControl = self.assetsTableView.refreshControl,
           refreshControl.isRefreshing {
        
            CFRunLoopPerformBlock(CFRunLoopGetMain(),
                                  CFRunLoopMode.commonModes.rawValue) {
                self.assetsTableView.refreshControl?.endRefreshing()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CryptoAssetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let assets = assets else {return .zero}
        switch searching {
        case .active:
            return filteredCryptoAssets.count
        case .inactive:
            return assets.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let assets = self.assets else {
            return UITableViewCell()
        }
        
        if let cell = assetsTableView.dequeueReusableCell(withIdentifier: CryptoAssetsTableViewCell.identifier,
                                                          for: indexPath) as? CryptoAssetsTableViewCell {
            cell.configureWith(delegate: nil, and: assets[indexPath.row], image: nil)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension CryptoAssetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let asset = assets?[indexPath.row] else { return }
        viewDetails(asset)
    }
}

// MARK: - CryptoAssetsTableViewCellDelegate
extension CryptoAssetsViewController: CryptoAssetsTableViewCellDelegate {
    func viewDetails(_ asset: CryptoAsset) {
        viewModel?.assetDetailsTapped(asset: asset)
    }
}

// MARK: - CryptoAssetsPresenterOutput
extension CryptoAssetsViewController: CryptoAssetsPresenterOutput {
    func update(_ assets: CryptoAssets) {
        self.assets = assets
        
        DispatchQueue.main.async {
            self.removeSpinner()
            self.assetsTableView.reloadData()
        }
    }
    
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: NetworkError.networkError.rawValue.localized(),
                                 message: error.rawValue.localized(),
                                 buttonTitle: Constants.Common.ok.localized())
    }
    
}

// MARK: - UISearchBarDelegate
extension CryptoAssetsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     
        guard let text = searchController.searchBar.text,
              let assets = assets
              else {
            return
        }
        
        // TODO: - Extract logic
        if searchText.isEmpty {
            searching = .inactive
            filteredCryptoAssets = assets
        } else {
            searching = .active
            filteredCryptoAssets = assets.filter({ (asset) -> Bool in
                ((asset.id?
                    .lowercased()
                    .contains(text.lowercased())) != nil)
                ||
                ((asset.symbol?
                    .lowercased()
                    .contains(text.lowercased())) != nil)
                
            })
        }
        
        DispatchQueue.main.async {
            self.assetsTableView.reloadData()
        }
    }
}
