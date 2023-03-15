//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 26.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

protocol GFFollowerItemViewControllerDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFFollowerItemViewControllerDelegate!
    
    init(user: User, delegate: GFFollowerItemViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user!)
    }
}

private extension GFFollowerItemViewController {
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user?.followers ?? .zero)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user?.following ?? .zero)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
