//
//  SwiftUICryptoAssetsView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 30.10.2024.
//

import SwiftUI

struct SwiftUICryptoAssetsView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                
                Text("Secondary Text Color")
                    .foregroundColor(Color.theme.secondaryText)
                
                Text("Positive Color")
                    .foregroundColor(Color.theme.positive)
                
                Text("Negative Color")
                    .foregroundColor(Color.theme.negative)
                
                Text("Accent Color")
                    .foregroundColor(Color.theme.primaryText)
            }
            .font(.headline)
        }
    }
}

#Preview {
    SwiftUICryptoAssetsView()
}
