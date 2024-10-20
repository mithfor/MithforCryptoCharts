//
//  CryptoAssetsViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit
import MFNetwork

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
    @available(*, deprecated, message: "Use fetchCryptoAssets() async throws instead")
    func fetchCryptoAssets()
    func fetchCryptoAssets() async
}

enum SearchActionState {
    case active
    case inactive
}

// MARK: - CryptoAssetsViewController
class CryptoAssetsViewController: UIViewController {
    
    private var viewModel: CryptoAssetListViewModel?
    
    var interactor: CryptoAssetsViewControllerOutput?
    
    private var assetViewModels: [CryptoAssetCellViewModel] = []
    
    private var assets: CryptoAssets?
    private var filteredCryptoAssets: CryptoAssets = []
    private var assetModel: AssetModel = [:]
    private var searching: SearchActionState = .inactive
    private var state: TableState = .initiate
        
    lazy var assetsTableView = CryptoAssetsTableView()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()

    // MARK: - Init
    init(viewModel: CryptoAssetListViewModel) {
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
        self.state = .refreshing
        
        Task {
            await interactor?.fetchCryptoAssets()
        }
        
        // TODO: - Todo module
        startTodos()
    }
    
    private func fetchTodos(_ todosService: TodosAPIService) -> Task<(), Never> {
        return Task {
            do {
                let todo = try await todosService.getTodos()
                print(#function, todo)
            } catch {
                print(#function, error)
            }
        }
    }
    
    private func fetchTodo(by id: Int, _ todosService: TodosAPIService) -> Task<(), Never> {
        return Task {
            do {
                if let todo = try await todosService.getTodo(with: id) {
                    print("Fetched todo: \(todo.title) - Complited: \(todo.completed)")
                } else {
                    print("Error fetching todo")
                }
                
            } catch {
                print("Failed to fetch todo: \(error)")
            }
        }
    }
    
    private func createTodo(_ todosService: TodosAPIService) -> Task<(), Never> {
        Task {
            do {
                let newTodo = try await todosService.create(userId: 1, title: "КУПИТЬ ВСЁ")
                print("Created todo: \(newTodo.title) with id: \(newTodo.userId)")
            } catch {
                print("Faild to create todo: \(error)")
            }
        }
    }
    
    func startTodos() {
        guard let baseURL = URL(string: "https://jsonplaceholder.typicode.com") else {
            return
        }
        
        let authorizationMiddleware = AuthorizationMiddleWare(token: "auth-token")
        let loggingMiddleware = LoggingMiddleware(logger: Logger())
        
        let apiClient: APIClient? = APIClient(
            baseURL: baseURL,
            middlewares:
                [
                    authorizationMiddleware,
                    loggingMiddleware
                ])
        let todosService = TodosAPIService(apiClient: apiClient)
        
//        _ = fetchTodos(todosService)
//        _ = fetchTodo(by: 1, todosService)
        _ = createTodo(todosService)
        
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
        
        Task {
            await interactor?.fetchCryptoAssets()
        }
        
        self.searchController.searchBar.text = ""
        
        // TODO: - how to test is endRefreshing?
        if let refreshControl = self.assetsTableView.refreshControl,
           refreshControl.isRefreshing {
        
            CFRunLoopPerformBlock(CFRunLoopGetMain(),
                                  CFRunLoopMode.commonModes.rawValue) {
                self.assetsTableView.refreshControl?.endRefreshing()
                self.state = .active
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
        
        if let cell = assetsTableView.dequeueReusableCell(
            withIdentifier: CryptoAssetsTableViewCell.identifier,
            for: indexPath) as? CryptoAssetsTableViewCell {
                        
            if let viewModel = CryptoAssetCellViewModelFactory.createViewModel(
                with: assets[indexPath.row],
                and: self) as? CryptoAssetCellViewModel {
                cell.configure(with: viewModel)
            }
            
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
