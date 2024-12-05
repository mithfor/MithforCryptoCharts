//
//  ButtonLinkStyle.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 05.12.2024.
//

import SwiftUI

struct ButtonLinkStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .tint(.blue)
            .font(.headline)
    }
}

extension View {
    func buttonLinkStyle() -> some View {
        modifier(ButtonLinkStyle())
    }
}


