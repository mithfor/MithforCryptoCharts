//
//  Color + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 30.10.2024.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let primaryText = Color("PrimaryTextColor")
    let background = Color("BackgroundColor")
    let negative = Color("NegativeColor")
    let positive = Color("PositiveColor")
    let secondaryText = Color("SecondaryTextColor")
}
