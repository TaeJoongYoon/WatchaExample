//
//  AppDelegate.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import UIKit

import Swinject
import Toaster

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: Properties
  
  var dependency: AppDependency!
  
  // MARK: UI
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    self.dependency = self.dependency ?? CompositionRoot.resolve()
    self.dependency.configureAppearance()
    self.window = self.dependency.window
    
    return true
  }

}
