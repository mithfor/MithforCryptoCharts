//
//  DetailView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 02.12.2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel

    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(String(describing: coin.name))")
    }

    var body: some View {
        Text("Hello")
    }
}

// MARK: - Previews

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
