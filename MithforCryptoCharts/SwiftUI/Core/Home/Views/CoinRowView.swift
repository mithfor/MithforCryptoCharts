//
//  CoinRowView.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 31.10.2024.
//

import SwiftUI

struct CoinRowView: View {
    
    var coin: CoinModel
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(coin.currentPrice)")
                    .bold()
                    .foregroundColor(Color.theme.primaryText)
                Text("\(coin.marketCapChangePercentage24H ?? 0)%")
                    .foregroundColor((coin.marketCapChangePercentage24H ?? 0) < 0
                                     ? Color.theme.negative
                                     : Color.theme.positive)
                
            }
            
        }
        
    }
}

struct CoinRowViewPreviews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
