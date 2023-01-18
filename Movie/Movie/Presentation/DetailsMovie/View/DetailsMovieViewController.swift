// DetailsMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран детали о фильме
class DetailsMovieViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let detailsCellIdentifier = "Details"
        static let relatedCellIdentifier = "Relate"
        static let alertTitleText = "Ой!"
        static let alertMessageText = "Произошла ошибка(("
        static let alertActionTitleText = "Ok"
        static let sizeForItemAtWidthValue = 150
        static let sizeForItemAtHeightValue = 200
        static let detailsMovieTableViewIdentifier = "DetailsMovie"
        static let cellIdentifier = "cellIdentifier"
    }

    // MARK: - Private Outlets

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: Public Properties

    var presenter: DetailsMoviePresenterProtocol?

    var updateCollectionViewHandler: (() -> ())?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureTableView()
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(DetailsMovieTableViewCell.self, forCellReuseIdentifier: Constants.detailsCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.accessibilityIdentifier = Constants.detailsMovieTableViewIdentifier
    }

    // MARK: - Constrains

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

/// UITableViewDataSource
extension DetailsMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailsCellIdentifier)
            as? DetailsMovieTableViewCell else { return UITableViewCell() }
        guard let model = presenter?.movieDetails,
              let imageService = presenter?.imageService
        else { return UITableViewCell() }
        cell.configure(model, imageService: imageService)
        cell.accessibilityIdentifier = "\(Constants.cellIdentifier)\(indexPath.row)"
        cell.collectionView.register(
            RelatedMoviesCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.relatedCellIdentifier
        )

        updateCollectionViewHandler = {
            cell.collectionView.reloadData()
        }
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

/// UICollectionViewDataSource
extension DetailsMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.recommendationMovies.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let movie = presenter?.recommendationMovies[indexPath.row],
              let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: Constants.relatedCellIdentifier,
                  for: indexPath
              ) as? RelatedMoviesCollectionViewCell,
              let imageService = presenter?.imageService
        else { return UICollectionViewCell() }
        cell.configure(movie, imageService: imageService)

        return cell
    }
}

/// UICollectionViewDelegateFlowLayout
extension DetailsMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: Constants.sizeForItemAtWidthValue, height: Constants.sizeForItemAtHeightValue)
    }
}

/// DetailsMovieViewProtocol
extension DetailsMovieViewController: DetailsMovieViewProtocol {
    func reloadCollectionView() {
        updateCollectionViewHandler?()
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func failure() {
        showAlert(
            title: Constants.alertTitleText,
            message: Constants.alertMessageText,
            actionTitle: Constants.alertActionTitleText,
            handler: nil
        )
    }
}
