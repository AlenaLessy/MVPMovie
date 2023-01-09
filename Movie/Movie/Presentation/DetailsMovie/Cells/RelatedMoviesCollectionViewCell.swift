//
//  RelatedMoviesCollectionViewCell.swift
//  Movie
//
//  Created by Алена Панченко on 27.10.2022.
//

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

    // MARK: - Private Methods

    private func addSubviews() {
        contentView.addSubview(movieImageView)
    }

    func update(_ movie: RecommendationMovie) {
        guard let url = movie.posterPath else { return }
        movieImageView.loadImage(urlImage: url)
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
