//
//  MainTabBarController.swift
//  MithforCryptoCharts
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
            return UITabBarItem(title: Constants.Title.assets,
                                image: UIImage(systemName: Constants.IconFill.assets),
                                tag: MainTabs.allCases.firstIndex(of: .assets) ?? 0)
        case .watchlist:
            return UITabBarItem(title: Constants.Title.watchlist,
                                image: UIImage(systemName: Constants.IconFill.watchlist),
                                tag: MainTabs.allCases.firstIndex(of: .watchlist) ?? 1)
        case .settings:
            return UITabBarItem(title: Constants.Title.settings,
                                image: UIImage(systemName: Constants.IconFill.settings),
                                tag: MainTabs.allCases.firstIndex(of: .settings) ?? 2)
        }
    }
}

    // MARK: - MainTabBarController
final class MainTabBarController: UITabBarController {
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    required init?(coder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemBlue
    }
}
