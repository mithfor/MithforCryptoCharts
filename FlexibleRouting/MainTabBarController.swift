//
//  MainTabBarController.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

enum MainTabs: CaseIterable {
    case assets
    case watchlist
    case settings

    var item: UITabBarItem {
        switch self {
        case .assets:
            return UITabBarItem(title: Constants.Strings.Title.assets,
                                image: UIImage(systemName:  Constants.Strings.IconFill.assets),
                                tag: MainTabs.allCases.firstIndex(of: .assets) ?? 0)
        case .watchlist:
            return UITabBarItem(title: Constants.Strings.Title.watchlist,
                                image: UIImage(systemName: Constants.Strings.IconFill.watchlist),
                                tag: MainTabs.allCases.firstIndex(of: .watchlist) ?? 1)
        case .settings:
            return UITabBarItem(title: Constants.Strings.Title.settings,
                                image: UIImage(systemName: Constants.Strings.IconFill.settings),
                                tag: MainTabs.allCases.firstIndex(of: .settings) ?? 2)
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
        
        tabBar.tintColor = .systemBlue
    }
}
