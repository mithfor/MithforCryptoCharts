//
//  CircleButtonView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 30.10.2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.primaryText)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.primaryText.opacity(0.25),
                    radius: 10,
                    x: 0.0,
                    y: 0.0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark )
        }
    }
}
