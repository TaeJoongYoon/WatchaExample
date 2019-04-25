//
//  MovieListViewController.swift
//  WatchaExample
//
//  Created by Tae joong Yoon on 25/04/2019.
//  Copyright © 2019 Tae joong Yoon. All rights reserved.
//

import ReusableKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class MovieListViewController: BaseViewController {
  
  // MARK: Constants
  
  struct Reusable {
    static let movieCell = ReusableCell<MovieCell>()
  }
  
  struct Metric {
    static let lineSpacing: CGFloat = 2
    static let intetItemSpacing: CGFloat = 0
    static let edgeInset: CGFloat = 9
    static let cellHeight: CGFloat = 150
    static let cellInset: CGFloat = 20
  }
  
  // MARK: Properties
  
  var viewModel: MovieListViewModelType!
  
  // MARK: UI
  
  let movieListCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
      $0.backgroundColor = .contentBackground
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.refreshControl = UIRefreshControl()
      $0.refreshControl?.tintColor = .tintColor
      $0.register(Reusable.movieCell)
  }
  
  let indicator = UIActivityIndicatorView(style: .whiteLarge).then {
    $0.color = .mainColor
  }
  
  // MARK: Initialize
  
  init(viewModel: MovieListViewModelType) {
    self.viewModel = viewModel
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup UI
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "WATCHA PLAY".localized
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    
    self.view.addSubview(self.movieListCollectionView)
    self.view.addSubview(self.indicator)
  }
  
  // MARK: Setup Constraints
  
  override func setupConstraints() {
    
    self.movieListCollectionView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeArea.top)
      make.left.right.equalToSuperview()
      make.bottom.equalTo(self.view.safeArea.bottom)
    }
    
    self.indicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
  }
  
  // MARK: - -> Rx Event Binding
  
  override func bindingEvent() {
    
    self.rx.viewDidLoad
      .bind(to: viewModel.inputs.viewDidLoad)
      .disposed(by: self.disposeBag)
    
    self.movieListCollectionView.refreshControl?.rx.controlEvent(.valueChanged)
      .bind(to: viewModel.inputs.didPulltoRefresh)
      .disposed(by: self.disposeBag)
    
    self.movieListCollectionView.rx.itemSelected
      .bind { [weak self] in
        guard let self = self else { return }
        self.viewModel.inputs.itemSelected(index: $0.row)
      }
      .disposed(by: self.disposeBag)
    
  }
  
  // MARK: - <- Rx UI Binding
  
  override func bindingUI() {
    
    self.movieListCollectionView.rx.setDelegate(self)
      .disposed(by: self.disposeBag)
    
    viewModel.outputs.movieList
      .asObservable()
      .bind(to: self.movieListCollectionView.rx.items(
        cellIdentifier: Reusable.movieCell.identifier,
        cellType: MovieCell.self)
      ) { row, element, cell in
        cell.configure(with: element)
      }.disposed(by: self.disposeBag)
    
    viewModel.outputs.movieDetail
      .subscribe(onNext : { [weak self] in
        self?.movieDetail($0, $1)
      })
      .disposed(by: self.disposeBag)
    
    viewModel.outputs.isPending
      .drive(onNext: { [weak self] isPending in
        self?.showPendingAnimation(isPending)
      }).disposed(by: self.disposeBag)
    
  }
  
  // MARK: Action Handler
  
  private func showPendingAnimation(_ idPending: Bool) {
    if !idPending {
      self.indicator.stopAnimating()
      self.movieListCollectionView.refreshControl?.endRefreshing()
    } else if !movieListCollectionView.refreshControl!.isRefreshing {
      self.indicator.startAnimating()
    }
  }
  
  private func movieDetail(_ movie: Movie, _ index: Int) {
    let viewControlelr = appDelegate.container.resolve(MovieDetailViewController.self,
                                                       argument: movie)!
    viewControlelr.didSelectItem = { [weak self] rating in
      self?.viewModel.inputs.updateList(index: index, rating: rating)
    }
    self.navigationController?.pushViewController(viewControlelr, animated: true)
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.bounds.size.width - Metric.cellInset),
                  height: Metric.cellHeight)
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.intetItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: Metric.edgeInset,
                        left: Metric.edgeInset,
                        bottom: Metric.edgeInset,
                        right: Metric.edgeInset)
  }
}
