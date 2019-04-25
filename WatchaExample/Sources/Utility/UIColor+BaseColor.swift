//
//  UIColor+BaseColor.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import UIKit

extension UIColor {
  static var mainColor: UIColor {
    return .black
  }
  
  static var tintColor: UIColor {
    return .black
  }
  
  static var backgroundColor: UIColor {
    return .black
  }
  
  static var contentBackground: UIColor {
    return UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1.0)
  }
  
  static var disabledColor: UIColor {
    return UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.5)
  }
  
  static var textfieldColor: UIColor {
    return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
  }
}
