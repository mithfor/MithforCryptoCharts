//
//  DetailView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 02.12.2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(String(describing: coin.name))")
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                    .background(Color.theme.positive)

                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()

                LazyVGrid(columns: columns,
                          alignment: .leading,
                          spacing: spacing,
                          pinnedViews: [],
                          content: {
                    ForEach(viewModel.overviewStatistics) { stat in
                        StatisticView(stat: stat)
                    }
                })

                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                LazyVGrid(columns: columns,
                          alignment: .leading,
                          spacing: spacing,
                          pinnedViews: [],
                          content: {
                    ForEach(viewModel.additionalStatistics) { stat in
                        StatisticView(stat: stat)
                    }
                })
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
}

// MARK: - Previews

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
