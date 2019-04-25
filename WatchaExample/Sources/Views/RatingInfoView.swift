//
//  RatingInfoView.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import UIKit

final class RatingInfoView: UIView {
  
  // MARK: Constant
  
  struct Metric {
    static let fontSize: CGFloat = 14
    static let spacing: CGFloat = 5
    static let offset: CGFloat = 10
  }
  
  // MARK: UI
  
  lazy var predictedLabel: UILabel = {
    let titleLabel = UILabel(frame: .zero)
    titleLabel.font = titleLabel.font.withSize(Metric.fontSize)
    
    return titleLabel
  }()
  
  lazy var ratingImageView: UIImageView = {
    let posterImageView = UIImageView(frame: .zero)
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    return posterImageView
  }()
  
  lazy var ratingLabel: UILabel = {
    let infoLabel = UILabel(frame: .zero)
    infoLabel.font = infoLabel.font.withSize(Metric.fontSize)
    
    return infoLabel
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [predictedLabel, ratingImageView, ratingLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = Metric.spacing
    
    return stackView
  }()
  
  // MARK: Properties
  
  var type: RatingInfoType
  
  // MARK: Initialize
  
  init(frame: CGRect, type: RatingInfoType) {
    self.type = type
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup View
  
  private func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(self.stackView)
    setupContent()
    setupConstraints()
  }
  
  // MARK: Setup Constraints
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.leftAnchor.constraint(equalTo: leftAnchor),
      stackView.rightAnchor.constraint(equalTo: rightAnchor),
      stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
  
      ratingImageView.widthAnchor.constraint(equalToConstant: 10),
      ratingImageView.heightAnchor.constraint(equalToConstant: 10)
      ])
  }
  
  // MARK: Setup Content
  
  func setupContent() {
    var color: UIColor
    var title: String
    var image: UIImage?
    switch self.type {
    case .predict:
      color = .tintColor
      title = "Predict".localized
      image = UIImage(named: "little-tint-star")
    case .average:
      color = .gray
      title = "Average".localized
      image = UIImage(named: "little-black-star")
    }
    
    self.predictedLabel.text = title
    self.predictedLabel.textColor = color
    
    self.ratingImageView.image = image
    
    self.ratingLabel.text = title
    self.ratingLabel.textColor = color
  }
}
