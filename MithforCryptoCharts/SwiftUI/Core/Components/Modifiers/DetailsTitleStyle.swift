//
//  DetailTitleStyle.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 05.12.2024.
//


import SwiftUI

struct DetailsTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(Color.theme.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension Text {
    func detailsTitleStyle() -> some View {
        modifier(DetailsTitleStyle())
    }
}
