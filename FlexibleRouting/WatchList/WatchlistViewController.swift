//
//  WatchlistViewController.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

//MARK: - WatchlistViewController
final class WatchlistViewController: UIViewController {
    
    private var viewModel: WatchlistViewModel?
    
    //MARK: - Init
    init(viewModel: WatchlistViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    //MARK: - Setup
    fileprivate func setupUI() {
        view.backgroundColor = .systemPink
        self.title = Constants.Title.watchlist
    }
}


//MARK: - WatchlistViewModel
final class WatchlistViewModel {
    typealias Routes = WatchlistTabRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func viewAsetTapped() {
        print("WatchlistViewModel: \(#function)")
    }
}


