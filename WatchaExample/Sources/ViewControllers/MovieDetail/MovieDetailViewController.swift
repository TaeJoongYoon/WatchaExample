//
//  MovieDetailViewController.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import RxCocoa
import RxSwift

final class MovieDetailViewController: BaseViewController {
  
  // MARK: Constants
  
  struct Metric {
    
  }
  
  // MARK: Properties
  
  var movie: Movie!
  var viewModel: MovieDetailViewModelType!
  
  // MARK: UI
  
  let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil).then {
    $0.tintColor = .white
  }
  
  let movieInfoContainerView = MovieInfoContainerView(frame: .zero)
  
  // MARK: Setup UI
  
  init(viewModel: MovieDetailViewModelType,
       movie: Movie) {
    self.viewModel = viewModel
    self.movie = movie
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = self.shareButton
    
    self.movieInfoContainerView.setupContent(with: self.movie)
    self.view.addSubview(self.movieInfoContainerView)
  }
  
  // MARK: Setup Constraints
  
  override func setupConstraints() {
   
    self.movieInfoContainerView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.top.equalTo(self.navigationController!.navigationBar.snp.top)
    }
    
  }
  
  // MARK: - -> Rx Event Binding
  
  override func bindingEvent() {
    
    
  }
  
  // MARK: - <- Rx UI Binding
  
  override func bindingUI() {
    
  }
  
  // MARK: Action Handler
}
