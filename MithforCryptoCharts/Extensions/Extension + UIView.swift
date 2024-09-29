//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 04.02.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToEdges(of superview: UIView, with constant: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant)
        ])
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
