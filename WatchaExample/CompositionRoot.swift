//
//  CompositionRoot.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 26/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import UIKit

import Kingfisher
import SnapKit
import Then
import Toaster

struct AppDependency {
  let window: UIWindow
  let configureAppearance: () -> Void
}

final class CompositionRoot {
  /// Builds a dependency graph and returns an entry view controller.
  static func resolve() -> AppDependency {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()
    
    let jsonService = LocalJSONService()
    
    let movieListViewController = MovieListViewController(
      viewModel: MovieListViewModel(jsonService: jsonService),
      movieDetailViewControllerFactory: { movie in
        MovieDetailViewController(
          viewModel: MovieDetailViewModel(),
          movie: movie)
      }
    )
    
    let navigationController = UINavigationController(rootViewController: movieListViewController)
    window.rootViewController = navigationController
    
    return AppDependency(
      window: window,
      configureAppearance: self.configureAppearance)
  }
  
  static func configureAppearance() {
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().clipsToBounds = true
    UINavigationBar.appearance().barTintColor = .white
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    ToastView.appearance().font = UIFont.preferredFont(forTextStyle: .subheadline)
  }
}
