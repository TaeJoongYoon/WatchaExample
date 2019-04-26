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
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel(frame: .zero)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = titleLabel.font.withSize(Metric.fontSize)
    
    return titleLabel
  }()
  
  lazy var ratingImageView: UIImageView = {
    let posterImageView = UIImageView(frame: .zero)
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    return posterImageView
  }()
  
  lazy var ratingLabel: UILabel = {
    let ratingLabel = UILabel(frame: .zero)
    ratingLabel.translatesAutoresizingMaskIntoConstraints = false
    ratingLabel.font = ratingLabel.font.withSize(Metric.fontSize)
    
    return ratingLabel
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel, ratingImageView, ratingLabel])
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
      // stackView
      stackView.leftAnchor.constraint(equalTo: leftAnchor),
      stackView.rightAnchor.constraint(equalTo: rightAnchor),
      stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      // titleLabel
      titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
      
      // infoLabel
      ratingLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
      ratingLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
  
      // ratingImageView
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
      title = "PREDICT".localized
      image = UIImage(named: "little-tint-star")
    case .average:
      color = .gray
      title = "AVERAGE".localized
      image = UIImage(named: "little-black-star")
    }
    
    self.titleLabel.text = title
    self.titleLabel.textColor = color
    
    self.ratingImageView.image = image
    
    self.ratingLabel.text = "0.0"
    self.ratingLabel.textColor = color
  }
  
  func setRating(_ rating: Double) {
    self.ratingLabel.text = String(format: "%.1f", rating)
  }
}
