//
//  AssetsViewController.swift
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

protocol AssetsViewControllerInput: AnyObject, ResultError {
    func update(_ assets: Assets)
}

protocol AssetsViewControllerOutput: AnyObject {
    func fetchAssets()
    func fetchImage(for asset: Asset, completion: @escaping (() -> Void))
}

enum SearchActionState {
    case active
    case inactive
}

// TODO: - Fix AssetWithImage to AssetViewModel!!!
struct AssetViewModel {
    let asset: Asset
    let image: UIImage
}

// MARK: - AssetsViewController
class AssetsViewController: UIViewController {
    
    private var viewModel: AssetListViewModel?
    
    // TODO: - remove optional if needed
    var interactor: AssetsViewControllerOutput?
    
    private var assetViewModels: [AssetViewModel] = []
    
    private var assets: Assets?
    private var filteredAssets: Assets = []
    private var assetModel: AssetModel = [:]
    private var searching: SearchActionState = .inactive
        
    lazy var assetsTableView: AssetsTableView = {
        let tableView = AssetsTableView()
        tableView.register(AssetsTableViewCell.self,
                           forCellReuseIdentifier: AssetsTableViewCell.identifier)
        
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
        interactor?.fetchAssets()
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
        
        interactor?.fetchAssets()
        
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
extension AssetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let assets = assets else {return .zero}
        switch searching {
        case .active:
            return filteredAssets.count
        case .inactive:
            return assets.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let assets = self.assets else {
            return UITableViewCell()
        }
        
        if let cell = assetsTableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier,
                                                          for: indexPath) as? AssetsTableViewCell {
            cell.configureWith(delegate: nil, and: assets[indexPath.row], image: nil)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension AssetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let asset = assets?[indexPath.row] else { return }
        viewDetails(asset)
    }
}

// MARK: - AssetsTableViewCellDelegate
extension AssetsViewController: AssetsTableViewCellDelegate {
    func viewDetails(_ asset: Asset) {
        viewModel?.assetDetailsTapped(asset: asset)
    }
}

// MARK: - AssetsPresenterOutput
extension AssetsViewController: AssetsPresenterOutput {
    func update(_ assets: Assets) {
        self.assets = assets
        
        DispatchQueue.main.async {
            self.removeSpinner()
            self.assetsTableView.reloadData()
        }
    }
    
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: NetworkError.title.rawValue,
                                 message: error.rawValue,
                                 buttonTitle: Constants.Common.ok)
    }
    
}

// MARK: - UISearchBarDelegate
extension AssetsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     
        guard let text = searchController.searchBar.text,
              let assets = assets
              else {
            return
        }
        
        // TODO: - Extract logic
        if searchText.isEmpty {
            searching = .inactive
            filteredAssets = assets
        } else {
            searching = .active
            filteredAssets = assets.filter({ (asset) -> Bool in
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
