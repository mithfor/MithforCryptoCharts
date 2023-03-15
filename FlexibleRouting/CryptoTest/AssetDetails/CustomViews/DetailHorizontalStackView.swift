//
//  DetailHorizontalStackView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 28.02.2023.
//

import UIKit

class DetailHorizontalStackView: UIStackView {

    lazy var leftLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textAlignment = .left

        return label
    }()
    
    lazy var rightLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.axis = .horizontal
    
        backgroundColor = .white
        
        addArrangedSubview(leftLabel)
        addArrangedSubview(rightLabel)
    }
}
