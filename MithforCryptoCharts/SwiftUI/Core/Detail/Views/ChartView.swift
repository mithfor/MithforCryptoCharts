//
//  ChartView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 04.12.2024.
//

import SwiftUI

struct ChartView: View {

    let data: [Double]
    let maxY: Double
    let minY: Double
    let lineColor: Color

    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0.0
        minY = data.min() ?? 0.0

        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.positive : Color.theme.negative
    }

    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis, alignment: .leading)
                .padding()
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
                .stroke(lineColor,
                        style: StrokeStyle(lineWidth: 3.0,
                                           lineCap: .round,
                                           lineJoin: .round
                                          ))
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
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
