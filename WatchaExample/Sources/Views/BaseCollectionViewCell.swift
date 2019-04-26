//
//  BaseCollectionViewCell.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 26/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
  
  var disposeBag = DisposeBag()
  
  // MARK: Initializing
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }
  
}
