//
//  MovieCell.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import Cosmos
import RxCocoa
import RxSwift

final class MovieCell: BaseCollectionViewCell {
  
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
  
  private let ratingView = CosmosView(frame: .zero).then {
    $0.rating = 0
    $0.settings.starSize = Metric.starSize
    $0.settings.updateOnTouch = true
    $0.settings.emptyImage = UIImage(named: "empty-star.png")
    $0.settings.filledImage = UIImage(named: "filled-star.png")
    $0.settings.fillMode = .half
    $0.settings.emptyBorderWidth = 1.0
  }
  
  private let moreButton = UIButton(type: .system).then {
    $0.setImage(UIImage(named:"more.png"), for: .normal)
    $0.tintColor = .lightGray
  }
  
  private let separatorLine = UIView(frame: .zero).then {
    $0.backgroundColor = .lightGray
  }
  
  // MARK: - Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
    setupConstraints()
  }
  
  // MARK: Setup UI
  
  private func setupUI() {
    self.contentView.backgroundColor = .contentBackground
    
    self.contentView.addSubview(self.posterImageView)
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.infoLabel)
    self.contentView.addSubview(self.ratingView)
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
    
    self.ratingView.snp.makeConstraints { make in
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
  
  func configure(with movie: Movie, _ viewModel: MovieListViewModelType) {
    self.posterImageView.kf.setImage(with: URL(string: movie.poster))
    self.titleLabel.text = movie.title
    self.infoLabel.text = "\(movie.year)ㆍ\(movie.genre)"
    self.ratingView.rating = movie.rating
    
    self.moreButton.rx.tap
      .debounce(0.3, scheduler: MainScheduler.instance)
      .bind(to: viewModel.inputs.cellMoreButtonDidTapped)
      .disposed(by: self.disposeBag)
  }
  
  func rating() -> Double {
    return self.ratingView.rating
  }
  
}
