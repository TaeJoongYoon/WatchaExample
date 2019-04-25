//
//  MovieCell.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import UIKit

import Cosmos
import Kingfisher

final class MovieCell: UICollectionViewCell {
  
  // MARK: Constant
  
  struct Metric {
    static let titleFontSize: CGFloat = 15
    static let infoFontSize: CGFloat = 11
    static let defaultPosterWidth: CGFloat = 90
    static let defaultPosterHeight: CGFloat = 129
    static let defaultOffset: CGFloat = 10
    static let starSize: Double = 35
  }
  
  // MARK: - Properties
  
  private let posterImageView = UIImageView(frame: .zero).then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let titleLabel = UILabel(frame: .zero).then {
    $0.textColor = .white
    $0.font = UIFont.boldSystemFont(ofSize: Metric.titleFontSize)
  }
  
  private let infoLabel = UILabel(frame: .zero).then {
    $0.textColor = .lightGray
    $0.font = $0.font.withSize(Metric.infoFontSize)
  }
  
  private let rating = CosmosView(frame: .zero).then {
    $0.rating = 0
    $0.settings.starSize = Metric.starSize
    $0.settings.updateOnTouch = false
    $0.settings.emptyImage = UIImage(named: "empty-star.png")
    $0.settings.filledImage = UIImage(named: "filled-star.png")
    $0.settings.fillMode = .precise
    $0.settings.emptyBorderWidth = 1.0
  }
  
  private let moreButton = UIButton(type: .system).then {
    $0.setImage(UIImage(named:"more.png"), for: .normal)
    $0.tintColor = .lightGray
  }
  
  private let separatorLine = UIView(frame: .zero).then {
    $0.backgroundColor = .lightGray
  }
  
  // MARK: - UI Metrics
  
  private struct UI {
  }
  
  // MARK: - Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: leftAnchor),
      contentView.rightAnchor.constraint(equalTo: rightAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    
    setupUI()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    fatalError("Interface Builder is not supported!")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    fatalError("Interface Builder is not supported!")
  }
  
  // MARK: Setup UI
  
  private func setupUI() {
    self.contentView.backgroundColor = .contentBackground
    
    self.contentView.addSubview(self.posterImageView)
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.infoLabel)
    self.contentView.addSubview(self.rating)
    self.contentView.addSubview(self.moreButton)
    self.contentView.addSubview(self.separatorLine)
  }
  
  // MARK: Setup Constraints
  
  private func setupConstraints() {
    
    self.posterImageView.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.width.equalTo(Metric.defaultPosterWidth)
      make.height.equalTo(Metric.defaultPosterHeight)
      make.centerY.equalToSuperview()
    }
    
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.posterImageView.snp.top)
      make.left.equalTo(self.posterImageView.snp.right).offset(Metric.defaultOffset)
    }
    
    self.infoLabel.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.defaultOffset / 2)
      make.left.equalTo(self.posterImageView.snp.right).offset(Metric.defaultOffset)
    }
    
    self.rating.snp.makeConstraints { make in
      make.bottom.equalTo(self.posterImageView.snp.bottom)
      make.left.equalTo(self.posterImageView.snp.right).offset(Metric.defaultOffset)
    }
    
    self.moreButton.snp.makeConstraints { make in
      make.top.equalTo(self.posterImageView.snp.top)
      make.right.equalToSuperview()
    }
    
    self.separatorLine.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.height.equalTo(0.3)
      make.bottom.equalToSuperview()
    }
    
  }
  
  // MARK: - Cell Contents
  
  func configure(with movie: Movie) {
    self.posterImageView.kf.setImage(with: URL(string: movie.poster))
    self.titleLabel.text = movie.title
    self.infoLabel.text = "\(movie.year)ㆍ\(movie.genre)"
    
  }
  
  func setStar(rating: Double) {
    self.rating.rating = rating
  }
}