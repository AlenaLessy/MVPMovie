//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Алена Панченко on 25.10.2022.
//

import UIKit

// Ячейка фильма
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Private

    // MARK: - Private Outlets

    private var movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 5
        return label
    }()

    private var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .yellow
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        configureLayoutAnchor()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func addSubviews() {
        addSubview(movieImageView)
        addSubview(movieNameLabel)
        addSubview(movieDescriptionLabel)
        addSubview(movieRatingLabel)
    }

    func update(_ movie: Movie) {
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
        movieRatingLabel.text = movie.rating.description
        guard let url = movie.posterPath else { return }
        movieImageView.loadImage(urlImage: url)
    }

    // MARK: - Constrains

    private func configureLayoutAnchor() {
        movieImageViewConstraint()
        movieNameLabelConstraint()
        movieDescriptionLabelConstraint()
        movieRatingLabelConstraint()
    }

    private func movieImageViewConstraint() {
        let constraint = movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        constraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.widthAnchor.constraint(equalToConstant: 120),
            constraint
        ])
    }

    private func movieNameLabelConstraint() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func movieDescriptionLabelConstraint() {
        NSLayoutConstraint.activate([
            movieDescriptionLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 5),
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func movieRatingLabelConstraint() {
        NSLayoutConstraint.activate([
            movieRatingLabel.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor, constant: 5),
            movieRatingLabel.leadingAnchor.constraint(equalTo: movieDescriptionLabel.leadingAnchor, constant: -45),
            movieRatingLabel.trailingAnchor.constraint(equalTo: movieDescriptionLabel.trailingAnchor),
            movieRatingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
