//
//  CryptoAssetsTableView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import UIKit

enum TableState {
    case initiate
    case active
    case refreshing
}

class CryptoAssetsTableView: UITableView {
    
    private(set) var state: TableState?
    
    init(frame: CGRect = .zero, style: UITableView.Style = .plain, state: TableState = .initiate) {
        self.state = state
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
