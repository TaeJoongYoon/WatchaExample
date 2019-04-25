//
//  Movie.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import Foundation

struct Movie: ModelType {
  enum Event { }
  
  var code: String
  var title: String
  var year: Int
  var poster: String
  var stillcut: String
  var nation: String
  var genre: String
  var rating = Double(0)
  
  enum CodingKeys: String, CodingKey {
    case code = "code"
    case title = "title"
    case year = "year"
    case poster = "poster"
    case stillcut = "stillcut"
    case nation = "nation"
    case genre = "genre"
  }
}
