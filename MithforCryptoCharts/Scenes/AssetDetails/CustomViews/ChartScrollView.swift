//
//  ChartScrollView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 02.03.2023.
//

import DGCharts
import UIKit

protocol ChartUpdateable {
    func updateLineChart()
}

class ChartScrollView: UIScrollView {
    
    var yValues = [ChartDataEntry]()
    
    private var maxY: Double?
    private var minY: Double?

    private lazy var lineChartView: LineChartView = {
        let view = LineChartView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private funcs
    
    private func configureChart() {
        
        configureViewConstraints()
        configureChartConstraints()
        configureAxis()
        configureLegend()
        
        setupData()
        
    }
    
    private func configureViewConstraints() {
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
    
    private func configureChartConstraints() {
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.autoScaleMinMaxEnabled = true
        contentView.addSubview(lineChartView)
//        contentView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 10).isActive = true
//        contentView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 10).isActive = true

        contentView.backgroundColor = .systemBackground
        lineChartView.pinToEdges(of: contentView)

    }
    
    private func configureAxis() {
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.drawGridBackgroundEnabled = false
        
        lineChartView.xAxis.enabled = false
    }
    
    private func configureLegend() {
        lineChartView.legend.enabled = false
    }
    
    private func setupData() {
        
        lineChartView.isUserInteractionEnabled = false
        
        let lineChartDataSet = LineChartDataSet(entries: yValues, label: "VALUE")
        
        maxY = lineChartDataSet.yMax
        minY = lineChartDataSet.yMin
        
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.lineWidth = 1
        lineChartDataSet.setColor(.black)
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        lineChartView.data = lineChartData
        
        lineChartView.animate(xAxisDuration: TimeInterval(Constants.Animation.chartAnimationDuration))
        
        lineChartView.renderer = ChartRenderer(view: lineChartView,
                                               minValue: minY ?? 0.0,
                                               maxValue: maxY ?? 0.0)
    }
}

extension ChartScrollView: ChartUpdateable {
    func updateLineChart() {
        setupData()
    }
}


