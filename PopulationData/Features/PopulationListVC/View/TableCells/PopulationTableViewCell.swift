//
//  PopulationTableViewCell.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import UIKit


class PopulationTableViewCell: UITableViewCell {
    
    weak var delegate: PopulationTableViewCellDelegate?
    
    private let backgroundCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = UIConstants.PopulationTableViewCell.cardCornerRadius
        view.layer.shadowColor = UIColor(red: 100/255, green: 100/255, blue: 111/255, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 29 / 2
        view.layer.shadowOffset = CGSize(width: 0, height: 7)
        view.backgroundColor = UIConstants.PopulationTableViewCell.cardBackgroundColor
        return view
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.PopulationTableViewCell.titleFontSize)
        label.textColor = .darkGray
        return label
    }()
    
    private let populationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.PopulationTableViewCell.subtitleFontSize)
        label.textColor = .gray
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.PopulationTableViewCell.subtitleFontSize)
        label.textColor = .gray
        return label
    }()
    
    private let regionTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(UIConstants.PopulationTableViewCell.detailButtonTitle, for: .normal)
        button.backgroundColor = UIConstants.PopulationTableViewCell.detailButtonBackgroundColor
        button.setTitleColor(UIConstants.PopulationTableViewCell.detailButtonTitleColor, for: .normal)
        button.titleLabel?.font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.PopulationTableViewCell.subtitleFontSize)
        button.layer.cornerRadius = UIConstants.PopulationTableViewCell.detailButtonCornerRadius
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        setupUI()
    }
    
    private var regionData: Any?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        contentView.addSubview(backgroundCardView)
        backgroundCardView.addSubview(regionTypeImageView)
        backgroundCardView.addSubview(regionLabel)
        backgroundCardView.addSubview(populationLabel)
        backgroundCardView.addSubview(yearLabel)
        backgroundCardView.addSubview(detailButton)
        
        NSLayoutConstraint.activate([
            backgroundCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backgroundCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroundCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            regionTypeImageView.topAnchor.constraint(equalTo: backgroundCardView.topAnchor, constant: 20),
            regionTypeImageView.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 20),
            regionTypeImageView.widthAnchor.constraint(equalToConstant: UIConstants.PopulationTableViewCell.regionImageWidth),
            regionTypeImageView.heightAnchor.constraint(equalToConstant: UIConstants.PopulationTableViewCell.regionImageHeight),
            
            regionLabel.centerYAnchor.constraint(equalTo: regionTypeImageView.centerYAnchor),
            regionLabel.leadingAnchor.constraint(equalTo: regionTypeImageView.trailingAnchor, constant: 10),
            regionLabel.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor, constant: -20),
            
            populationLabel.topAnchor.constraint(equalTo: regionTypeImageView.bottomAnchor, constant: 20),
            populationLabel.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 20),
            populationLabel.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor, constant: -20),
            
            yearLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 20),
            yearLabel.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor, constant: -20),
            
            detailButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 20),
            detailButton.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 20),
            detailButton.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor, constant: -20),
            detailButton.bottomAnchor.constraint(equalTo: backgroundCardView.bottomAnchor, constant: -20),
            detailButton.heightAnchor.constraint(equalToConstant: UIConstants.PopulationTableViewCell.detailButtonHeight)
        ])
    }
    
    @objc private func detailButtonTapped() {
        if let regionData = regionData {
            delegate?.didTapDetailButton(for: regionData)
        }
    }
    
    func configure(with data: Any) {
        self.regionData = data
        
        if let stateData = data as? StateModel {
            regionLabel.text = stateData.stateName
            
           
            let populationText = "Population: \(stateData.population)"
            let attributedPopulationString = NSMutableAttributedString(string: populationText)
           
            attributedPopulationString.addAttribute(.font, value: UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.PopulationTableViewCell.subtitleFontSize)!, range: NSRange(location: 0, length: 10))
            populationLabel.attributedText = attributedPopulationString
            
           
            let yearText = "Year: \(stateData.year)"
            let attributedYearString = NSMutableAttributedString(string: yearText)
            attributedYearString.addAttribute(.font, value: UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.PopulationTableViewCell.subtitleFontSize)!, range: NSRange(location: 0, length: 4))
            yearLabel.attributedText = attributedYearString
            
            regionTypeImageView.image = UIImage(systemName: "building.2")
            regionTypeImageView.tintColor = UIConstants.Colors.primary
            backgroundCardView.backgroundColor = UIConstants.PopulationTableViewCell.stateBackgroundColor
        } else if let nationData = data as? NationModel {
            regionLabel.text = nationData.nationName
            
    
            let populationText = "Population: \(nationData.population)"
            let attributedPopulationString = NSMutableAttributedString(string: populationText)
            attributedPopulationString.addAttribute(.font, value: UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.PopulationTableViewCell.subtitleFontSize)!, range: NSRange(location: 0, length: 10))
            populationLabel.attributedText = attributedPopulationString
            
            let yearText = "Year: \(nationData.year)"
            let attributedYearString = NSMutableAttributedString(string: yearText)
            attributedYearString.addAttribute(.font, value: UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.PopulationTableViewCell.subtitleFontSize)!, range: NSRange(location: 0, length: 4))
            yearLabel.attributedText = attributedYearString
            
            regionTypeImageView.image = UIImage(systemName: "globe")
            regionTypeImageView.tintColor = UIConstants.Colors.primary
            backgroundCardView.backgroundColor = UIConstants.PopulationTableViewCell.nationBackgroundColor
        }
    }


}
