// RelatedMoviesCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка рекомендованных фильмов
final class RelatedMoviesCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Outlets

    private var relatedContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()

    private var movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .brown
        image.layer.cornerRadius = 15
        return image
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureLayoutAnchor()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func update(_ movie: RecommendationMovie, networkService: NetworkServiceProtocol) {
        guard let urlString = movie.posterPath else { return }
        fetchImage(networkService: networkService, urlString: urlString)
        reloadInputViews()
    }

    // MARK: - Private Methods

    private func addSubviews() {
        contentView.addSubview(movieImageView)
    }

    private func fetchImage(networkService: NetworkServiceProtocol, urlString: String) {
        networkService.fetchImage(imageUrlPath: urlString) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    self.movieImageView.image = UIImage(data: data)
                }
            case .failure:
                print(NetworkError.unknown.description)
            }
        }
    }

    // MARK: - Constrains

    private func configureLayoutAnchor() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
