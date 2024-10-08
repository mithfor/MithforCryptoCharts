//
//  CryptoAssetsTableViewCell.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 25.02.2023.
//

import UIKit

protocol CryptoAssetsTableViewCellDelegate: AnyObject {
    func viewDetails(_ asset: CryptoAsset)
}

class CryptoAssetsTableViewCell: UITableViewCell {
    
    // TODO: - make ViewModel
    private var asset: CryptoAsset?
    
    static let identifier = "CryptoAssetsTableViewCell"
    
    weak var delegate: CryptoAssetsTableViewCellDelegate?
    
    private var assetId: String = ""
    private var assetImage: UIImage?
    
    private var assetDetailsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.Icon.details),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var assetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        return imageView
    }()

    private var assetSymbolLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textColor = ColorConstants.Asset.symbol
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var assetNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = ColorConstants.Asset.name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var assetPriceUSDLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = ColorConstants.Asset.priceUSD
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private var assetChangePercent24HrLabel: ChangePercent24HrLabel = {
        let label = ChangePercent24HrLabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = ColorConstants.Asset.changePercent24HrPositive
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func assetDetailsButtonDidTap() {
        guard let asset = asset else {return}
        delegate?.viewDetails(asset)
    }
    
    // MARK: - Setup
    private func setupUI() {
       autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
       contentView.addSubview(assetDetailsButton)
        selectionStyle = .none
    
        contentView.clipsToBounds = true
        contentView.contentMode = .center
        contentView.isMultipleTouchEnabled = true

        assetDetailsButton.contentVerticalAlignment = .center
        assetDetailsButton.tintColor = UIColor.systemGray2
        assetDetailsButton.titleLabel?.lineBreakMode = .byTruncatingMiddle
        assetDetailsButton.addTarget(self,
                                     action: #selector(assetDetailsButtonDidTap),
                                     for: .touchUpInside)
        contentView.addSubview(assetImageView)
        
        contentView.addSubview(assetSymbolLabel)
        contentView.addSubview(assetNameLabel)
        
        contentView.addSubview(assetPriceUSDLabel)
        contentView.addSubview(assetChangePercent24HrLabel)

    }
    
    // MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            assetDetailsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            assetDetailsButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            assetDetailsButton.heightAnchor.constraint(equalToConstant: 22),
            assetDetailsButton.widthAnchor.constraint(equalToConstant: 16),
            
            assetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            assetImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            assetImageView.widthAnchor.constraint(equalToConstant: 60),
            assetImageView.heightAnchor.constraint(equalToConstant: 60),
            
            assetSymbolLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: 8),
            assetSymbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            assetNameLabel.leadingAnchor.constraint(equalTo: assetSymbolLabel.leadingAnchor),
            assetNameLabel.topAnchor.constraint(equalTo: assetSymbolLabel.bottomAnchor, constant: 0),
            
            assetPriceUSDLabel.trailingAnchor.constraint(equalTo: assetDetailsButton.leadingAnchor, constant: -8),
            assetPriceUSDLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            assetChangePercent24HrLabel.trailingAnchor.constraint(equalTo: assetPriceUSDLabel.trailingAnchor),
            assetChangePercent24HrLabel.topAnchor.constraint(equalTo: assetPriceUSDLabel.bottomAnchor, constant: 4)
            
        ])
    }
    
    func configure(with viewModel: CryptoAssetCellViewModel) {
        self.delegate = viewModel.delegate
        self.asset = viewModel.asset
        self.assetImage = viewModel.image
        
        update()
    }
    
    @available(*, deprecated, message: "Use configure(with viewModel:) instead")
    func configureWith(delegate: CryptoAssetsTableViewCellDelegate?,
                       and asset: CryptoAsset,
                       image: UIImage) {
        self.delegate = delegate
        self.asset = asset
        self.assetImage = image
        
        update()
    }
    
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else  { return }
            self.assetImageView.image = assetImage
            self.assetSymbolLabel.text = asset?.symbol
            self.assetNameLabel.text = asset?.name
            self.assetPriceUSDLabel.text = "$\(String.formatToCurrency(string: asset?.priceUsd ?? ""))"
            self.assetChangePercent24HrLabel.setupText(with: Double(asset?.changePercent24Hr ?? "0.00") ?? 0.0)
        }
    }
 }
