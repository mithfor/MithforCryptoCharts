//
//  MainTabBarController.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

enum Tabs {
    case assets
    case watchlist
    case settings
    
    var index: Int {
        switch self {
        case .assets:
            return 0
        case .watchlist:
            return 1
        case .settings:
            return 2
        }
    }
    
    var item: UITabBarItem {
        switch self {
        case .assets:
            return UITabBarItem(title: Constants.Title.assets, image: UIImage(systemName:  Constants.IconFill.assets), tag: index)
        case .watchlist:
            return UITabBarItem(title: Constants.Title.watchlist, image: UIImage(systemName: Constants.IconFill.watchlist), tag: index)
        case .settings:
            return UITabBarItem(title: Constants.Title.settings, image: UIImage(systemName: Constants.IconFill.settings), tag: index)
        }
    }
}


//Mark: - MainTabBarController
final class MainTabBarController: UITabBarController {
    
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
    }
}
