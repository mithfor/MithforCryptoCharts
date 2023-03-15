//
//  AppConstants.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import UIKit

struct AppConstants {
    static let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    static let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    static let navigationItemTextSize: CGFloat = 17
}
