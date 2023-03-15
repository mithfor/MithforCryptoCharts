//
//  AssetsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit
//import SwiftUI

typealias AssetsWithImages = [Asset: UIImage]
typealias AssetImage = UIImage

protocol AssetsViewControllerInput: AnyObject {
    func updateAssets(assets: Assets)
    func updateFailed(with error: NetworkError)
}

protocol AssetsViewControllerOutput: AnyObject {
    func fetchAssets()
    func fetchImageFor(asset: Asset, completion: @escaping (AssetIcon) -> ())
}

enum ActionState {
    case active
    case inactive
}

//MARK: - AssetsViewController


class AssetsViewController: UIViewController {
    
    private var viewModel: AssetsViewModel?
    
    var interactor: AssetsInteractorInput?
    
    private var assets: Assets?
    private var filteredAssets = Assets()
    private var assetWithImage = AssetsWithImages()
    private var searching: ActionState = .inactive
    
    let assetsTableView: AssetsTableView = {
       let tableView = AssetsTableView()
        tableView.register(AssetsTableViewCell.self,
                           forCellReuseIdentifier: AssetsTableViewCell.identifier)
        tableView.backgroundColor = Constants.Color.mainBackground
        
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

       // TODO: - replace with CFRunLoopPerformBlock
        
//        CFRunLoopPerformBlock(<#T##rl: CFRunLoop!##CFRunLoop!#>, <#T##mode: CFTypeRef!##CFTypeRef!#>, <#T##block: (() -> Void)!##(() -> Void)!##() -> Void#>)
        DispatchQueue.main.async {
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
                                   image: assetWithImage[assets[indexPath.row]])
            case .active:
                cell.configureWith(delegate: self,
                                   and:  filteredAssets[indexPath.row],
                                   image: assetWithImage[filteredAssets[indexPath.row]])
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
    func details(of asset: Asset) {
        
//        let vc = AssetDetailsConfigurator.configured( AssetDetailsViewController(asset: asset))
//        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - AssetsPresenterOutput
extension AssetsViewController: AssetsPresenterOutput {
    func updateFailed(with error: NetworkError) {
        presentAlertOnMainThread(title: Constants.Network.title, message: error.rawValue, buttonTitle: "OK")
    }
    
    
    func updateAssets(assets: Assets) {
        self.assets = assets
        self.filteredAssets = assets
        
        let group = DispatchGroup()
        
        self.assets?.forEach { [weak self] asset in
            group.enter()
            self?.interactor?.fetchImageFor(asset: asset) {  [weak self] (assetIcon) in
                self?.assetWithImage[asset] = assetIcon.image
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.assetsTableView.reloadData()
        }
        
    }
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
                (asset.id?.lowercased().contains(text.lowercased()) ?? false)})
        }
    
        assetsTableView.reloadData()
    }
}

//MARK: - AssetsViewModel
final class AssetsViewModel {
    typealias Routes = AssetsTabRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func viewAssetTapped() {
        print("AssetsViewModel: \(#function)")
    }
}



//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        AssetsViewController().showPreview()
//    }
//}

