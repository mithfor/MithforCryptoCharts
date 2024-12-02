//
//  DetailLoadingView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 02.12.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}


// MARK: - Previews

struct DetailLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLoadingView(coin: .constant(dev.coin))
    }
}
