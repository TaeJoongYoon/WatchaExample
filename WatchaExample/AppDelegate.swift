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

  var window: UIWindow?
  let container = Container()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    // Window configure
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    // Toaster configure
    ToastView.appearance().bottomOffsetPortrait = (window?.safeAreaInsets.bottom)! + CGFloat(55)
    ToastView.appearance().font = UIFont.preferredFont(forTextStyle: .subheadline)
    
    // Appearance configure
    UINavigationBar.appearance().barTintColor = .white
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    
    // DI
    dependencyInject()
    
    return true
  }

}

extension AppDelegate {
  func dependencyInject() {
    let jsonService = LocalJSONService()
    
    container.register(MovieListViewController.self) { r in
      let viewModel = MovieListViewModel(jsonService: jsonService)
      let controller = MovieListViewController(viewModel: viewModel)
      return controller
    }
    
    container.register(MovieDetailViewController.self) { (r: Resolver, movie: Movie) in
      let viewModel = MovieDetailViewModel()
      let controller = MovieDetailViewController(viewModel: viewModel, movie: movie)
      return controller
    }
    
    let navigationController = UINavigationController(
      rootViewController: container.resolve(MovieListViewController.self)!
    )
    
    navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController.navigationBar.clipsToBounds = true
    self.window?.rootViewController = navigationController
  }
}
