//
//  SettingsViewController.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

//MARK: - SettingsViewController
final class SettingsViewController: UIViewController {
    
    private var viewModel: SettingsViewModel?
    
    //MARK: - Init
    init(viewModel: SettingsViewModel) {
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
        view.backgroundColor = .yellow
        self.title = Constants.Strings.Title.settings
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

final class SettingsViewModel {
    typealias Routes = SettingsTabRoute
    private let router: Routes
    
    init(router:Routes) {
        self.router = router
    }
    
    func viewIconTapped() {
        print("SettingsViewModel: \(#function)")
    }
    
}
