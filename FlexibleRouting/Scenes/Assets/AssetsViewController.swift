//
//  AssetsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit
//import SwiftUI

typealias AssetId = String
typealias AssetImage = UIImage

typealias AssetModel = [AssetId: AssetImage]

protocol AssetsViewControllerInput: AnyObject {
//    func updateAssets(_ assets: Assets)
//    func updateAsset(_ asset: Asset, with assetIcon: AssetIcon)
    func updateAssets(_ assets: Assets, with assetModel: AssetModel)
    func updateFailed(with error: NetworkError)
}

protocol AssetsViewControllerOutput: AnyObject {
    func fetchAssets()
    func fetchImageFor(asset: Asset, completion: @escaping (() -> ()))
}

enum ActionState {
    case active
    case inactive
}

//MARK: - AssetsViewController


struct AssetWithImage {
    let asset = Asset()
    let image: UIImage
}

class AssetsViewController: UIViewController {
    
    private var viewModel: AssetsViewModel?
    
    var interactor: AssetsInteractorInput?
    
    private var assets: Assets?
    private var filteredAssets: Assets = []
    private var assetModel: AssetModel = [:]
    private var searching: ActionState = .inactive
        
    
    let assetsTableView: AssetsTableView = {
       let tableView = AssetsTableView()
        tableView.register(AssetsTableViewCell.self,
                           forCellReuseIdentifier: AssetsTableViewCell.identifier)
        tableView.backgroundColor = Constants.Colors.mainBackground
        
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()

    //MARK: - Init
    init(viewModel: AssetsViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overriden
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
        
        self.title = Constants.Strings.Title.assets
        
        assetsTableView.dataSource = self
        assetsTableView.delegate = self
        
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
        
        CFRunLoopPerformBlock(CFRunLoopGetMain(),
                              CFRunLoopMode.defaultMode.rawValue) {
            self.searchController.searchBar.text = ""
              
            self.assetsTableView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension AssetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let assets = assets else {return .zero}
        switch searching {
            case .active: return filteredAssets.count
            case .inactive: return assets.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let assets = self.assets else {
            return UITableViewCell()
        }
        
        if let cell = assetsTableView.dequeueReusableCell(withIdentifier: AssetsTableViewCell.identifier,
                                                          for: indexPath) as? AssetsTableViewCell {
            
            switch searching {
            case .inactive:
                cell.configureWith(delegate: self,
                                   and:  assets[indexPath.row],
                                   image: assetModel[assets[indexPath.row].id ?? "bitcoin"])
            case .active:
                cell.configureWith(delegate: self,
                                   and:  filteredAssets[indexPath.row],
                                   image: assetModel[filteredAssets[indexPath.row].id ?? "bitcoin"])
            }

            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension AssetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight

    }
}
//MARK: - AssetsTableViewCellDelegate
extension AssetsViewController: AssetsTableViewCellDelegate {
    func viewDetails(_ asset: Asset) {
        viewModel?.assetDetailsTapped(asset: asset)
    }
}

// MARK: - AssetsPresenterOutput
extension AssetsViewController: AssetsPresenterOutput {
    func updateAssets(_ assets: Assets, with assetModel: AssetModel) {
        self.assets = assets
        self.assetModel = assetModel
        
        DispatchQueue.main.async {
            self.removeSpinner()
            self.assetsTableView.reloadData()
        }
    }
    
    
    func updateAsset(_ asset: Asset, with assetIcon: AssetIcon) {
        if let id = asset.id {
            assetModel[id] = assetIcon.image
        }
        
        print(assetModel)
        CFRunLoopPerformBlock(CFRunLoopGetMain(),
                              CFRunLoopMode.defaultMode.rawValue) {
            self.assetsTableView.reloadData()
        }
    }
    
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: Constants.Strings.Error.Network.title,
                                 message: error.rawValue,
                                 buttonTitle: Constants.Strings.Common.ok)
    }
    
    
//    func updateAssets(_ assets: Assets) {
//
//        print(#function)
//        self.assets = assets
//        self.filteredAssets = assets
//
//        let group = DispatchGroup()
//
//        //TODO: - Move to Interactor!
//        let queue = DispatchQueue(label: "FetchingImageForAssetQueue",
//                                  qos: .default,
//                                  attributes: .concurrent)
//
////        queue.async {
//            self.assets?.forEach { [weak self] asset in
//                group.enter()
//
//                self?.interactor?.fetchImageFor(asset: asset) {
//                    group.leave()
//                }
//            }
//
//            group.notify(queue: .global(qos: .userInitiated)) {
//                CFRunLoopPerformBlock(CFRunLoopGetMain(),
//                                      CFRunLoopMode.defaultMode.rawValue) {
//                    self.assetsTableView.reloadData()
//                }
//            }
////        }
//    }
}

//MARK: - UISearchBarDelegate
extension AssetsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
     
        guard let text = searchController.searchBar.text,
              let assets = assets
              else {
            return
        }
        
        if searchText.isEmpty {
            searching = .inactive
            filteredAssets = assets
        } else {
            searching = .active
            filteredAssets = assets.filter({ (asset) -> Bool in
                (asset.id?
                    .lowercased()
                    .contains(text.lowercased()) ?? false)
                ||
                    (asset.symbol?
                    .lowercased()
                    .contains(text.lowercased()) ?? false)
                
            })
        }
        
        DispatchQueue.main.async {
            self.assetsTableView.reloadData()
        }
    }
}

//MARK: - AssetsViewModel
final class AssetsViewModel {
    typealias Routes = AssetDetailsRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func assetDetailsTapped(asset: Asset) {
        router.openAssetDetails(asset)
    }
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetsViewController().showPreview()
//    }
//}

