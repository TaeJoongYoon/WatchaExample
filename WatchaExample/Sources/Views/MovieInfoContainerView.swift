//
//  MovieInfoContainerView.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import UIKit

import Kingfisher

final class MovieInfoContainerView: UIView {
  
  // MARK: Constant
  
  struct Metric {
    static let titleFontSize: CGFloat = 22
    static let infoFontSize: CGFloat = 15
    static let offset: CGFloat = 10
    static let defaultPosterWidth: CGFloat = 90
    static let defaultPosterHeight: CGFloat = 129
  }
  
  // MARK: UI
  
  lazy var stillcutImageView: UIImageView = {
    let stillcutImageView = UIImageView(frame: .zero)
    stillcutImageView.translatesAutoresizingMaskIntoConstraints = false
    stillcutImageView.contentMode = .scaleAspectFill
    stillcutImageView.clipsToBounds = true
    
    return stillcutImageView
  }()
  
  lazy var posterImageView: UIImageView = {
    let posterImageView = UIImageView(frame: .zero)
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    posterImageView.contentMode = .scaleAspectFit
    
    return posterImageView
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel(frame: .zero)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textColor = .white
    titleLabel.font = UIFont.boldSystemFont(ofSize: Metric.titleFontSize)
    
    return titleLabel
  }()
  
  lazy var infoLabel: UILabel = {
    let infoLabel = UILabel(frame: .zero)
    infoLabel.translatesAutoresizingMaskIntoConstraints = false
    infoLabel.textColor = .lightGray
    infoLabel.font = infoLabel.font.withSize(Metric.infoFontSize)
    
    return infoLabel
  }()
 
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  override var intrinsicContentSize: CGSize {
    //preferred content size, calculate it if some internal state changes
    return CGSize(width: UIScreen.main.bounds.width, height: 200)
  }
  
  // MARK: Setup View
  
  private func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(self.stillcutImageView)
    addSubview(self.posterImageView)
    addSubview(self.titleLabel)
    addSubview(self.infoLabel)
    
    setupConstraints()
  }
  
  // MARK: Setup Constraints
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // stillcutImageView
      self.stillcutImageView.topAnchor.constraint(equalTo: self.topAnchor),
      self.stillcutImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.stillcutImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.stillcutImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      
      // posterImageView
      self.posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Metric.offset),
      self.posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metric.offset),
      self.posterImageView.widthAnchor.constraint(equalToConstant: Metric.defaultPosterWidth),
      self.posterImageView.heightAnchor.constraint(equalToConstant: Metric.defaultPosterHeight),
      
      // titleLabel
      self.titleLabel.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor, constant: Metric.offset),
      self.titleLabel.bottomAnchor.constraint(equalTo: self.infoLabel.topAnchor, constant: -Metric.offset),
      
      // infoLabel
      self.infoLabel.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor, constant: Metric.offset),
      self.infoLabel.bottomAnchor.constraint(equalTo: self.posterImageView.bottomAnchor)
      ])
  }
  
  // MARK: Setup Content
  
  func setupContent(with movie: Movie) {
    self.stillcutImageView.kf.setImage(with: URL(string: movie.stillcut))
    self.posterImageView.kf.setImage(with: URL(string: movie.poster))
    self.titleLabel.text = movie.title
    self.infoLabel.text = "\(movie.year)ㆍ\(movie.nation)ㆍ\(movie.genre)"
  }
}
