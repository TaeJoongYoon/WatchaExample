//
//  MovieDetailViewModel.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import RxCocoa
import RxSwift

protocol MovieDetailViewModelInputs {
  var shareButtonDidTapped: PublishSubject<Void> { get }
  var ratingButtonDidTapped: PublishSubject<Double> { get }
}

protocol MovieDetailViewModelOutputs {
  var share: Driver<Void> { get }
  var rated: Driver<Double> { get }
}

protocol MovieDetailViewModelType: ViewModelType {
  var inputs: MovieDetailViewModelInputs { get }
  var outputs: MovieDetailViewModelOutputs { get }
}

final class MovieDetailViewModel: MovieDetailViewModelType, MovieDetailViewModelInputs, MovieDetailViewModelOutputs {
  var inputs: MovieDetailViewModelInputs { return self }
  var outputs: MovieDetailViewModelOutputs { return self }
  
  // MARK: Input
  
  let shareButtonDidTapped = PublishSubject<Void>()
  let ratingButtonDidTapped = PublishSubject<Double>()
  
  // MARK: Output
  
  let share: Driver<Void>
  let rated: Driver<Double>
  
  // MARK: Initialize
  
  init() {
    
    share = shareButtonDidTapped
      .asDriver(onErrorJustReturn: ())
    
    rated = ratingButtonDidTapped
      .asDriver(onErrorJustReturn: 0)
    
  }
}
