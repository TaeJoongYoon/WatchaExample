//
//  ViewType.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//


import UIKit
import RxSwift

protocol ViewType: class {
  associatedtype ViewModelType
  var viewModel: ViewModelType! { get set }
  
  func setupEventBinding()
  func setupUIBinding()
}

extension ViewType where Self: UIViewController {
  static func create(with viewModel: ViewModelType) -> Self {
    let `self` = Self()
    self.viewModel = viewModel
    self.loadViewIfNeeded()
    self.setupEventBinding()
    self.setupUIBinding()
    
    return self
  }
}
