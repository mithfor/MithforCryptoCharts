//
//  ChartRenderer.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import Foundation
import Charts

class ChartRenderer: LineChartRenderer {
    var xBounds = XBounds()
    
    var minValue: Double
    var maxValue: Double
    
    init(view: LineChartView, minValue: Double , maxValue: Double) {
        self.minValue = minValue
        self.maxValue = maxValue
        
        super.init(dataProvider: view,
                   animator: view.chartAnimator,
                   viewPortHandler: view.viewPortHandler)
    }
    
    override func drawValues(context: CGContext)
        {
            guard
                let dataProvider = dataProvider,
                let data = dataProvider.lineData
                else { return }


            let dataSets = data.dataSets

            let phaseY = animator.phaseY

            var point = CGPoint()

            for i in 0 ..< dataSets.count
            {
                guard let dataSet = dataSets[i] as? LineChartDataSet
                    else { continue }

                let valueFont = UIFont.systemFont(ofSize: 13, weight: .regular)
                let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)
                let valueToPixelMatrix = trans.valueToPixelMatrix

                xBounds.set(chart: dataProvider, dataSet: dataSet, animator: animator)

                let lineHeight = valueFont.lineHeight
                let yOffset: CGFloat = lineHeight + 5.0

                for j in stride(from: xBounds.min, through: xBounds.range + xBounds.min, by: 1)
                {
                    guard let entry = dataSet.entryForIndex(j) else { break }

                    guard entry.y == maxValue || entry.y == minValue else { continue }

                    point.x = CGFloat(entry.x)
                    if entry.y == maxValue {
                        point.y = CGFloat(entry.y * phaseY)
                    } else if entry.y == minValue {
                        point.y = CGFloat(entry.y * phaseY)
                    }
                    point = point.applying(valueToPixelMatrix)

                    if (!viewPortHandler.isInBoundsRight(point.x))
                    {
                        break
                    }

                    if (!viewPortHandler.isInBoundsLeft(point.x) || !viewPortHandler.isInBoundsY(point.y))
                    {
                        continue
                    }

                    if dataSet.isDrawValuesEnabled
                    {
                        // In this part we draw min and max values
                        var textValue: String?
                        if entry.y == maxValue {
                            point.y -= yOffset
                            textValue = "$\(String.formatToCurrency(string: String(maxValue)))"
                            
                        } else if entry.y == minValue {
                            point.y += yOffset / 5
                            textValue = "$\(String.formatToCurrency(string: String(minValue)))"
                        }

                        if let textValue = textValue {

                            context.drawText(textValue,
                                             at: CGPoint(
                                                x: point.x,
                                                y: point.y ),
                                             align: .center,
                                             attributes: [NSAttributedString.Key.font: valueFont, NSAttributedString.Key.foregroundColor: Constants.Color.Asset.priceUSD])
                        }
                    }
                }
            }
        }
}
