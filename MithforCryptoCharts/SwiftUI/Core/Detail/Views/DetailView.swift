//
//  DetailView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 02.12.2024.
//

import SwiftUI

struct DetailView: View {
    @Binding var coin: CoinModel?

    init(coin: Binding<CoinModel?>) {
        self._coin = coin
        print("Initializing Detail View for \(String(describing: coin.wrappedValue?.name))")
    }

    var body: some View {
        Text(coin?.name ?? "")
    }
}

// MARK: - Previews

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: .constant(dev.coin))
    }
}
