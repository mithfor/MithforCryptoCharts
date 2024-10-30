//
//  SettingsViewController.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

// MARK: - SettingsViewController
final class SettingsViewController: UIViewController {
    
    private var viewModel: SettingsViewModel?
    
    private var button: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("BUTTON", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc private func buttonTapped() {
        print(#function)
    }
    
    // MARK: - Init
    init(viewModel: SettingsViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup
    fileprivate func setupUI() {
        view.backgroundColor = .yellow
        self.title = Constants.Title.settings
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
    }
}

final class SettingsViewModel {
    typealias Routes = SettingsTabRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func viewIconTapped() {
        print("SettingsViewModel: \(#function)")
    }
}
