//
//  ChartScrollView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 02.03.2023.
//

import Charts
import UIKit

protocol Updateable {
    func updateLineChart()
}

class ChartScrollView: UIScrollView {

    private lazy var lineChartView: LineChartView = {
        let view = LineChartView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var yValues = [ChartDataEntry]()
    var maxY: Double?
    var minY: Double?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func createChart() {
        
        setupContentViewConstraints()
        
        //create line chart
        setupChartConstraints()
        
        //supply data
        setupData()
        
        //configure the axis
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.drawGridBackgroundEnabled = false
        
        lineChartView.xAxis.enabled = false
        lineChartView.isUserInteractionEnabled = false
        
        //configure legend
        lineChartView.legend.enabled = false
        
    }
    
    private func setupContentViewConstraints() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            heightConstraint,
        ])
    }
    
    private func setupChartConstraints() {
        contentView.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false

        lineChartView.pinToEdges(of: contentView)

    }
    
    private func setupData() {
        
        let lineChartDataSet = LineChartDataSet(entries: yValues, label: "VALUE")
        
        maxY = lineChartDataSet.yMax
        minY = lineChartDataSet.yMin
        
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.lineWidth = 1
        lineChartDataSet.setColor(.black)
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        lineChartView.data = lineChartData
        
        lineChartView.renderer = ChartRenderer(view: lineChartView,
                                               minValue: minY ?? 0.0,
                                               maxValue: maxY ?? 0.0)
    }
}

extension ChartScrollView: Updateable {
    func updateLineChart() {
        setupData()
    }
}


