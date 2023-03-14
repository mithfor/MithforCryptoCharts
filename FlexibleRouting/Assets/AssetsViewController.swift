//
//  AssetsViewController.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

//MARK: - AssetsViewController
final class AssetsViewController: UIViewController {
    
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
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .cyan
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

