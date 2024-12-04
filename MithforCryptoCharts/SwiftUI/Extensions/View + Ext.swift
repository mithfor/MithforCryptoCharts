//
//  View + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 04.12.2024.
//

import Foundation
import SwiftUI

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]
        return self
    }
}
