//
//  AssetsViewController_old.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

//MARK: - AssetsViewController
final class AssetsViewController_old: UIViewController {
    
    private var viewModel: AssetsViewModel?
    
    //MARK: - Init
    init(viewModel: AssetsViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        setupUI()
    }
    
    //MARK: - Setup
    fileprivate func setupUI() {
        view.backgroundColor = .cyan
        self.title = Constants.Title.assets
        navigationController?.navigationBar.prefersLargeTitles = true
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

