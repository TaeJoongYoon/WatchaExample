//
//  MovieDetailViewController.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import Cosmos
import RxCocoa
import RxSwift
import Toaster

final class MovieDetailViewController: BaseViewController {
  
  // MARK: Constants
  
  struct Metric {
    static let starSize: Double = Double(UIScreen.main.bounds.width / 7)
    static let buttonRadius: CGFloat = 5
    static let buttonInset: CGFloat = 3
    static let infoContainerHeight: CGFloat = 50
    static let offset: CGFloat = 10
    static let borderWidth: CGFloat = 0.5
  }
  
  // MARK: Properties
  
  var movie: Movie
  var viewModel: MovieDetailViewModelType
  var didSelectItem: ((Double) -> Void)?
  var toast: Toast?
  
  // MARK: UI
  
  let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil).then {
    $0.tintColor = .white
  }
  
  let movieInfoContainerView = MovieInfoContainerView(frame: .zero)
  
  let contentView = UIView(frame: .zero).then {
    $0.backgroundColor = .white
  }
  
  let infoContainerView = UIView(frame: .zero).then {
    $0.backgroundColor = .white
  }
  
  let predictContainerView = RatingInfoView(frame: .zero, type: .predict)
  let averageContainerView = RatingInfoView(frame: .zero, type: .average)
  
  let rating = CosmosView(frame: .zero).then {
    $0.rating = 0
    $0.settings.starSize = Metric.starSize
    $0.settings.updateOnTouch = true
    $0.settings.emptyImage = UIImage(named: "empty-star.png")
    $0.settings.filledImage = UIImage(named: "filled-star.png")
    $0.settings.fillMode = .half
    $0.settings.emptyBorderWidth = 1.0
  }
  
  let ratingButton = UIButton(type: .system).then {
    $0.setTitle("I Wanna Watch".localized, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleEdgeInsets = UIEdgeInsets(top: Metric.buttonInset,
                                      left: Metric.buttonInset,
                                      bottom: Metric.buttonInset,
                                      right: Metric.buttonInset)
    $0.backgroundColor = .tintColor
    $0.layer.cornerRadius = Metric.buttonRadius
    $0.clipsToBounds = true
  }
  
  // MARK: Initialize
  
  init(viewModel: MovieDetailViewModelType,
       movie: Movie) {
    self.viewModel = viewModel
    self.movie = movie
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup UI
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = self.shareButton
    
    self.rating.rating = self.movie.rating
    
    self.movieInfoContainerView.setupContent(with: self.movie)
    self.predictContainerView.setRating(self.movie.rating)
    self.averageContainerView.setRating(self.movie.rating)
    
    self.view.addSubview(self.movieInfoContainerView)
    
    self.infoContainerView.addSubview(self.predictContainerView)
    self.infoContainerView.addSubview(self.averageContainerView)
    
    self.contentView.addSubview(self.infoContainerView)
    self.contentView.addSubview(self.rating)
    self.contentView.addSubview(self.ratingButton)
    self.view.addSubview(self.contentView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.infoContainerView.layer.addBorder([.bottom], color: .lightGray, width: Metric.borderWidth)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.toast?.cancel()
  }
  
  // MARK: Setup Constraints
  
  override func setupConstraints() {
   
    self.movieInfoContainerView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.top.equalTo(self.navigationController!.navigationBar.snp.top)
    }
    
    self.contentView.snp.makeConstraints { make in
      make.top.equalTo(self.movieInfoContainerView.snp.bottom)
      make.left.right.equalToSuperview()
      make.bottom.equalTo(self.view.safeArea.bottom)
    }
    
    self.infoContainerView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalTo(Metric.infoContainerHeight)
    }
    
    self.predictContainerView.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(Metric.offset)
      make.centerY.equalToSuperview()
    }
    
    self.averageContainerView.snp.makeConstraints { make in
      make.left.equalTo(self.predictContainerView.snp.right).offset(Metric.offset)
      make.centerY.equalToSuperview()
    }
    
    self.rating.snp.makeConstraints { make in
      make.top.equalTo(self.infoContainerView.snp.bottom).offset(2 * Metric.offset)
      make.centerX.equalToSuperview()
    }
    
    self.ratingButton.snp.makeConstraints { make in
      make.top.equalTo(self.rating.snp.bottom).offset(2 * Metric.offset)
      make.centerX.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.4)
    }
    
  }
  
  // MARK: - -> Rx Event Binding
  
  override func bindingEvent() {
    
    self.shareButton.rx.tap
      .debounce(0.3, scheduler: MainScheduler.instance)
      .bind(to: viewModel.inputs.shareButtonDidTapped)
      .disposed(by: self.disposeBag)
    
    self.ratingButton.rx.tap
      .debounce(0.3, scheduler: MainScheduler.instance)
      .map { [weak self] in
        guard let self = self else { return 0.0 }
        return self.rating.rating
      }
      .bind(to: viewModel.inputs.ratingButtonDidTapped)
      .disposed(by: self.disposeBag)
    
  }
  
  // MARK: - <- Rx UI Binding
  
  override func bindingUI() {
    
    viewModel.outputs.share
      .drive(onNext: { [weak self] in
        self?.share()
      })
      .disposed(by: self.disposeBag)
    
    viewModel.outputs.rated
      .drive(onNext: { [weak self] in
        self?.rated($0)
      })
      .disposed(by: self.disposeBag)
    
  }
  
  // MARK: Action Handler
  
  private func share() {
    let item = "JUST WATCHA \(self.movie.title)"
    let items = [item]
    let activityViewController = UIActivityViewController(activityItems: items,
                                                          applicationActivities: nil)
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
    
    self.present(activityViewController, animated: true, completion: nil)
  }
  
  private func rated(_ rating: Double) {
    self.didSelectItem?(rating)
    
    self.predictContainerView.setRating(rating)
    self.averageContainerView.setRating(rating)
    
    self.toast?.cancel()
    self.toast = Toast(text: "Applied Your Rating!".localized, duration: Delay.long)
    self.toast?.show()
  }
}
