//
//  MovieListViewModel.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import RxCocoa
import RxSwift

protocol MovieListViewModelInputs {
  var viewDidLoad: PublishSubject<Void> { get }
  var didPulltoRefresh: PublishSubject<Void> { get }
  var modelSelected: PublishSubject<Movie> { get }
}

protocol MovieListViewModelOutputs {
  var isPending: Driver<Bool> { get }
  var movieList: Driver<[Movie]> { get }
  var movieDetail: Observable<Movie> { get }
}

protocol MovieListViewModelType: ViewModelType {
  var inputs: MovieListViewModelInputs { get }
  var outputs: MovieListViewModelOutputs { get }
}

final class MovieListViewModel: MovieListViewModelType, MovieListViewModelInputs, MovieListViewModelOutputs {
  var inputs: MovieListViewModelInputs { return self }
  var outputs: MovieListViewModelOutputs { return self }
  
  // MARK: Input
  
  let viewDidLoad = PublishSubject<Void>()
  let didPulltoRefresh = PublishSubject<Void>()
  let modelSelected = PublishSubject<Movie>()
  
  // MARK: Output
  
  let isPending: Driver<Bool>
  let movieList: Driver<[Movie]>
  let movieDetail: Observable<Movie>
  
  // MARK: Initialize
  
  init(jsonService: LocalJSONServiceType) {
    
    let onPending = PublishSubject<Bool>()
    isPending = onPending.asDriver(onErrorJustReturn: false)
    
    movieList = Observable.merge([viewDidLoad, didPulltoRefresh])
      .do(onNext: {_ in onPending.onNext(true)})
      .flatMapLatest { _ in
        jsonService.readMovieJSON()
          .do { onPending.onNext(false) }
      }
      .asDriver(onErrorJustReturn: [])
    
    movieDetail = modelSelected
      .asObservable()
  }
}
