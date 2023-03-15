//
//  ChangePercent24HrLabel.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import UIKit

class ChangePercent24HrLabel: UILabel {
    var value: Double = 0.0
    
    init() {
        
        super.init(frame: .zero)
        
        setupText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(with double: Double) {
        value = double
        setupText()
    }
    
    private func setupText() {

        let changePercent24HrTrend = value
        textColor = changePercent24HrTrend >= 0
                                                ? Constants.Color.Asset.changePercent24HrPositive
                                                : Constants.Color.Asset.changePersent24HrNegative

        let positiveSign = changePercent24HrTrend >= 0 ? "+" : ""

        text = "\(positiveSign)\(NSString(format: "%.2f", changePercent24HrTrend))%"
    }
}
