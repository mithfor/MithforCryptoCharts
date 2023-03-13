//
//  AssetsViewController.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

class AssetsViewController: UIViewController {

    private var viewModel: AssetsViewModel?
    
    init(viewModel: AssetsViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .cyan
    }


}

