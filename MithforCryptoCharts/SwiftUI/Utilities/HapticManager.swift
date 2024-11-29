//
//  HapticManager.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 29.11.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
