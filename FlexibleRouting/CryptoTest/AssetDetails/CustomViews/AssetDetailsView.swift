//
//  DetailView.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 28.02.2023.
//

import UIKit
import Charts

protocol AssetDetailAccessable: class {
    
    func updateLine1(with value: String)
    func updateLine2(with value: String)
    func updateLine3(with value: String)
    func updateAssetPriceUSD(with value: String, and color:  UIColor)
    func updateAssetChangePercent24Hr(with value: String)
    func updateHistoryChart(with data: [AssetHistory])
}

//protocol Refreshable: class {
//    func refreshData()
//}

final class AssetDetailsView: UIView {
    //MARK: - CHARTS
    
    
    //MARK: VARIABLES
    
    // TODO: return to private
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var assetPriceUSDLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 64, weight: .thin)
        label.textColor = Constants.Color.Asset.name
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private lazy var assetChangePercent24HrLabel: ChangePercent24HrLabel = {
        let label = ChangePercent24HrLabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chartScrollView: ChartScrollView = {
        let view = ChartScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 2

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    private lazy var stackLine1: DetailHorizontalStackView = {
        let stack = DetailHorizontalStackView()
        stack.leftLabel.text = "Market Cap"
        stack.leftLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.textColor = Constants.Color.Asset.priceUSD
        return stack
    }()
    
    private lazy var stackLine2: DetailHorizontalStackView = {
        let stack = DetailHorizontalStackView()
        stack.leftLabel.text = "Supply"
        stack.leftLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.textColor = Constants.Color.Asset.priceUSD
        return stack
    }()
    
    private lazy var stackLine3: DetailHorizontalStackView = {
        let stack = DetailHorizontalStackView()
        stack.leftLabel.text = "Volume (24h)"
        stack.leftLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.font = UIFont.systemFont(ofSize: Constants.Fonts.Size.normal, weight: .regular)
        stack.rightLabel.textColor = Constants.Color.Asset.priceUSD
        return stack
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
                
        setupScrollViewContstraints()
        setupContentViewConstraints()
        
        setupAssetPriceUSDLabelConstraints()
        setupAssetChangePercent24HrLabelConstraints()
        setupChartScrollViewConstraints()
        setupStackViewConstraints()
        setupLinesConstraints()
    }
    

    
    // MARK: - CONSTRAINTS METHODS
    
    private func setupScrollViewContstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupContentViewConstraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
        ])
    }
    
    private func setupAssetPriceUSDLabelConstraints(){
        contentView.addSubview(assetPriceUSDLabel)
        NSLayoutConstraint.activate([
            assetPriceUSDLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            assetPriceUSDLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            assetPriceUSDLabel.heightAnchor.constraint(equalToConstant: 76),
        ])
    }
    
    private func setupAssetChangePercent24HrLabelConstraints() {
        contentView.addSubview(assetChangePercent24HrLabel)
        NSLayoutConstraint.activate([
            assetChangePercent24HrLabel.topAnchor.constraint(equalTo: assetPriceUSDLabel.bottomAnchor, constant: 8),
            assetChangePercent24HrLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            assetChangePercent24HrLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    private func setupChartScrollViewConstraints() {
        contentView.addSubview(chartScrollView)
        NSLayoutConstraint.activate([
            chartScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chartScrollView.heightAnchor.constraint(equalToConstant: 240),
            chartScrollView.topAnchor.constraint(lessThanOrEqualTo: assetChangePercent24HrLabel.bottomAnchor, constant: 10)
        ])
        chartScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupStackViewConstraints() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 132),
            stackView.topAnchor.constraint(equalTo: chartScrollView.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupLinesConstraints() {
        
        stackView.addArrangedSubview(stackLine1)
        stackView.addArrangedSubview(stackLine2)
        stackView.addArrangedSubview(stackLine3)
        
        NSLayoutConstraint.activate([
            stackLine1.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 0),
            stackLine1.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            stackLine2.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 0),
            stackLine2.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            stackLine3.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 0),
            stackLine3.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}

// MARK: - AssetDetailAccessable
extension AssetDetailsView: AssetDetailAccessable {
    
    func updateHistoryChart(with data: [AssetHistory]) {
        
        data.enumerated().forEach { (index, item) in
            chartScrollView.yValues.append(ChartDataEntry(x: Double(index),
                                                          y: Double(item.priceUsd ?? "No Data") ?? 0.0))
        }
        
        DispatchQueue.main.async {
            self.chartScrollView.updateLineChart()
        }
    }
    
    func updateAssetPriceUSD(with text: String, and color: UIColor) {
        assetPriceUSDLabel.text = text
    }
    
    func updateAssetChangePercent24Hr(with value: String) {
        assetChangePercent24HrLabel.setupText(with: Double(value) ?? 0.0)
    }
    
    func updateLine1(with value: String) {
        stackLine1.rightLabel.text = value
    }
    
    func updateLine2(with value: String) {
        stackLine2.rightLabel.text = value
    }
    
    func updateLine3(with value: String) {
        stackLine3.rightLabel.text = value
    }
}


