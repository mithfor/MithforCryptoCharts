//
//  DetailView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 02.12.2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
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
            VStack(spacing: 20)
            {
                ChartView(coin: viewModel.coin)
                VStack {
                    overviewTitle
                    Divider()
                    descriptionSectionIfAvailable
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleTextStyle(Color.theme.primaryText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrainlingItems
            }
        }
    }
}

private extension DetailView {

    var navigationBarTrainlingItems: some View {
        HStack {
            Text(viewModel.coin.symbol)
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }

    var overviewTitle: some View {
        Text("Overview")
            .bold()
            .detailsTitleStyle()
    }

    var additionalTitle: some View {
        Text("Additional Details")
            .bold()
            .detailsTitleStyle()
    }

    var descriptionSectionIfAvailable: some View {
        VStack {
            if let coinDescription = viewModel.coinDescription,
               !coinDescription.isEmpty {
                showDescriptionSection(description: coinDescription)
            }
        }
    }

    func showDescriptionSection(description: String) -> some View {
        return VStack(alignment: .leading) {
            Text(description)
                .lineLimit(lineLimit)
                .font(.callout)
                .foregroundStyle(Color.theme.secondaryText)
            if description.count >= 100 {
                Button(action: {
                    withAnimation(.easeInOut) {
                        showFullDescription.toggle()
                    }
                }, label: {
                    withAnimation(showFullDescription ? Animation.easeInOut : Animation.default) {
                        Text(descriptionButtonTitle)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                })
                .buttonLinkStyle()
            }
        }
    }

    var lineLimit: Int {
        return showFullDescription ? .max : 3
    }

    var descriptionButtonTitle: String {
        return showFullDescription ? "Less" : "Read more..."
    }

    var websiteSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let websiteString = viewModel.websiteURL,
               let url = URL(string: websiteString) {
                Link(destination: url) {
                    Text("WebSite localized")
                        .buttonLinkStyle()
                }
            }

            if let redditLinkString = viewModel.redditURL,
               let url = URL(string: redditLinkString) {
                Link(destination: url) {
                    Text("Reddit localized")
                        .buttonLinkStyle()
                }
            }
        }

    }

    var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(viewModel.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }

    var additionalGrid: some View {
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
}

// MARK: - Previews

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
