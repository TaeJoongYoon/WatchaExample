//
//  localJSONService.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import RxSwift

protocol LocalJSONServiceType {
  func readMovieJSON() -> Single<[Movie]>
}

final class LocalJSONService: LocalJSONServiceType {
  func readMovieJSON() -> Single<[Movie]> {
    return Single.create { single in
      guard let path = Bundle.main.path(forResource: "movieList", ofType: "json") else { return Disposables.create() }
      
      let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      do {
        let movieList = try JSONDecoder().decode(MovieList.self, from: data)
        single(.success(movieList.movies))
      } catch let error {
        log.error(error)
        single(.error(error))
      }
      
      return Disposables.create()
    }
  }
}
