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
  func itemSelected(index: Int)
  func updateList(index: Int, rating: Double)
}

protocol MovieListViewModelOutputs {
  var isPending: Driver<Bool> { get }
  var movieList: BehaviorRelay<[Movie]> { get }
  var movieDetail: Observable<(Movie, Int)> { get }
}

protocol MovieListViewModelType: ViewModelType {
  var inputs: MovieListViewModelInputs { get }
  var outputs: MovieListViewModelOutputs { get }
}

final class MovieListViewModel: MovieListViewModelType, MovieListViewModelInputs, MovieListViewModelOutputs {
  var inputs: MovieListViewModelInputs { return self }
  var outputs: MovieListViewModelOutputs { return self }
  var disposeBag = DisposeBag()
  
  // MARK: Input
  
  let viewDidLoad = PublishSubject<Void>()
  let didPulltoRefresh = PublishSubject<Void>()
  private let _movieDetail = ReplaySubject<(Movie, Int)>.create(bufferSize: 1)
  func itemSelected(index: Int) {
    self._movieDetail.onNext((self.movieList.value[index], index))
  }
  func updateList(index: Int, rating: Double) {
    var newList = self.movieList.value
    newList[index].rating = rating
    self.movieList.accept(newList)
  }
  
  // MARK: Output
  
  let isPending: Driver<Bool>
  let movieList = BehaviorRelay<[Movie]>(value: [])
  let movieDetail: Observable<(Movie, Int)>
  
  // MARK: Initialize
  
  init(jsonService: LocalJSONServiceType) {
    
    let onPending = PublishSubject<Bool>()
    isPending = onPending.asDriver(onErrorJustReturn: false)
    
    Observable.merge([viewDidLoad, didPulltoRefresh])
      .do(onNext: {_ in onPending.onNext(true)})
      .flatMapLatest { _ in
        jsonService.readMovieJSON()
          .do { onPending.onNext(false) }
      }
      .bind(to: self.movieList)
      .disposed(by: self.disposeBag)
    
    movieDetail = _movieDetail
      .asObservable()
  }
}
