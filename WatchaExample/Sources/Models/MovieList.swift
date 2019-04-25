//
//  MovieList.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import Foundation

struct MovieList: ModelType {
  enum Event { }
  
  var movies: [Movie]
  
  enum CodingKeys: String, CodingKey {
    case movies = "data"
  }
}
