//
//  UIApplication + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 18.11.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
