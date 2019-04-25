//
//  MovieDetailViewModel.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import RxSwift

protocol MovieDetailViewModelInputs {
  
}

protocol MovieDetailViewModelOutputs {
  
}

protocol MovieDetailViewModelType: ViewModelType {
  var inputs: MovieDetailViewModelInputs { get }
  var outputs: MovieDetailViewModelOutputs { get }
}

final class MovieDetailViewModel: MovieDetailViewModelType, MovieDetailViewModelInputs, MovieDetailViewModelOutputs {
  var inputs: MovieDetailViewModelInputs { return self }
  var outputs: MovieDetailViewModelOutputs { return self }
  
  init() {
    
  }
}
