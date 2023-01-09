//
//  DetailMovieViewController.swift
//  Movie
//
//  Created by Алена Панченко on 26.10.2022.
//

import UIKit

// Экран детали о фильме
class DetailsMovieViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let detailsCellIdentifier = "Details"
        static let relatedCellIdentifier = "Relate"
    }

    // MARK: - Private Outlets

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: Public Properties

    var movieDetails: MovieDetails?

    // MARK: Private Properties

    private var recommendationMovies: [RecommendationMovie] = []
    private var recommendations: [Movie] = []
    private let networkService = NetworkService.shared

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureTableView()
        requestMovies()
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(DetailsMovieTableViewCell.self, forCellReuseIdentifier: Constants.detailsCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }

    private func requestMovies() {
        networkService.requestRecommendationsMovie(id: movieDetails?.id ?? 0) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                self.recommendationMovies = response.movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                break
            }
        }
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
        guard let model = movieDetails else { return UITableViewCell() }
        cell.update(model)
        cell.collectionView.register(
            RelatedMoviesCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.relatedCellIdentifier
        )
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
        recommendationMovies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let model = recommendationMovies[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.relatedCellIdentifier,
            for: indexPath
        ) as? RelatedMoviesCollectionViewCell
        else { return UICollectionViewCell() }
        cell.update(model)
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
        CGSize(width: 150, height: 200)
    }
}
