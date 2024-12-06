//
//  ChartView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 04.12.2024.
//

import SwiftUI

struct ChartView: View {

    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    private let priceChange: Bool

    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0.0
        minY = data.min() ?? 0.0

        priceChange = (data.last ?? 0) - (data.first ?? 0) > 0
        lineColor = priceChange ? Color.theme.positive : Color.theme.negative

        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")

        // One week in seconds
        let oneWeekInSeconds = -7*24*60*60
        startingDate = endingDate.addingTimeInterval(TimeInterval(oneWeekInSeconds))

    }

    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)

            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 2)) {
                    percentage = 1.0
                }
            }
        }
    }
}


extension ChartView {
    private var chartView: some View {
            GeometryReader { geometry in
                Path { path in
                    for index in data.indices {
                        let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)

                        let yAxis = maxY - minY
                        let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height

                        if index == 0 {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }

                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
                .trim(from: 0, to: percentage)
                .stroke(lineColor,
                        style: StrokeStyle(lineWidth: 2.0,
                                           lineCap: .round,
                                           lineJoin: .round
                                          ))
                .shadow(color: lineColor.opacity(0), radius: 10, x: 0, y: priceChange ? 10 : -10)
                .shadow(color: lineColor.opacity(1), radius: 10, x: 0, y: priceChange ? 10 : -10)
                .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: priceChange ? 20 : -20)
                .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: priceChange ? 30 : -30)
                .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: priceChange ? 40 : -40)
            }

    }

    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }

    private var chartYAxis: some View {
        VStack {
            Text(maxY.formatedWithAbbreviations())
            Spacer()
            let price = ((maxY + minY) / 2).formatedWithAbbreviations()
            Text(price)
            Spacer()
            Text(minY.formatedWithAbbreviations())
        }
    }

    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
