// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фильма
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let movieNameLabelFontSize: CGFloat = 17
        static let movieDescriptionLabelFontSize: CGFloat = 14
        static let movieRatingLabelFontSize: CGFloat = 20
        static let movieDescriptionLabelNumberOfLines = 5
    }

    private enum ConstantsOfConstraint {
        static let movieImageViewBottomValue: CGFloat = -16
        static let movieImageViewBottomPriorityValue: Float = 999
        static let movieImageViewTopValue: CGFloat = 16
        static let movieImageViewLeadingValue: CGFloat = 16
        static let movieImageViewHeightValue: CGFloat = 150
        static let movieImageViewWidthValue: CGFloat = 120
        static let movieNameLabelTopValue: CGFloat = 16
        static let movieNameLabelLeadingValue: CGFloat = 16
        static let movieNameLabelTrailingValue: CGFloat = -16
        static let movieDescriptionLabelTopValue: CGFloat = 5
        static let movieDescriptionLabelLeadingValue: CGFloat = 16
        static let movieDescriptionLabelTrailingValue: CGFloat = -16

        static let movieRatingLabelTopValue: CGFloat = 5
        static let movieRatingLabelLeadingValue: CGFloat = -45
        static let movieRatingLabelTrailingValue: CGFloat = -16
    }

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
        label.font = UIFont.systemFont(ofSize: Constants.movieNameLabelFontSize)
        return label
    }()

    private var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: Constants.movieDescriptionLabelFontSize)
        label.numberOfLines = Constants.movieDescriptionLabelNumberOfLines
        return label
    }()

    private var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .yellow
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.movieRatingLabelFontSize)
        return label
    }()

    // MARK: - Initializers

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

    // MARK: - Public Methods

    func configure(movie: Movie, imageService: ImageServiceProtocol) {
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
        movieRatingLabel.text = movie.rating.description
        guard let urlString = movie.posterPath else { return }
        fetchPhoto(imageService: imageService, urlString: urlString)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieNameLabel.text = nil
        movieDescriptionLabel.text = nil
        movieRatingLabel.text = nil
        movieImageView.image = nil
    }

    // MARK: - Private Methods

    private func addSubviews() {
        addSubview(movieImageView)
        addSubview(movieNameLabel)
        addSubview(movieDescriptionLabel)
        addSubview(movieRatingLabel)
    }

    private func fetchPhoto(imageService: ImageServiceProtocol, urlString: String) {
        imageService.fetchPhoto(byUrl: urlString) { [weak self] data in
            guard let data else { return }
            self?.movieImageView.image = UIImage(data: data)
        }
    }

    // MARK: - Constrains

    private func configureLayoutAnchor() {
        movieImageViewConstraint()
        movieNameLabelConstraint()
        movieDescriptionLabelConstraint()
        movieRatingLabelConstraint()
    }

    private func movieImageViewConstraint() {
        let constraint = movieImageView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: ConstantsOfConstraint.movieImageViewBottomValue
        )
        constraint.priority = UILayoutPriority(ConstantsOfConstraint.movieImageViewBottomPriorityValue)
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ConstantsOfConstraint.movieImageViewTopValue
            ),
            movieImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ConstantsOfConstraint.movieImageViewLeadingValue
            ),
            movieImageView.heightAnchor.constraint(equalToConstant: ConstantsOfConstraint.movieImageViewHeightValue),
            movieImageView.widthAnchor.constraint(equalToConstant: ConstantsOfConstraint.movieImageViewWidthValue),
            constraint
        ])
    }

    private func movieNameLabelConstraint() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ConstantsOfConstraint.movieNameLabelTopValue
            ),
            movieNameLabel.leadingAnchor.constraint(
                equalTo: movieImageView.trailingAnchor,
                constant: ConstantsOfConstraint.movieNameLabelLeadingValue
            ),
            movieNameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: ConstantsOfConstraint.movieNameLabelTrailingValue
            )
        ])
    }

    private func movieDescriptionLabelConstraint() {
        NSLayoutConstraint.activate([
            movieDescriptionLabel.topAnchor.constraint(
                equalTo: movieNameLabel.bottomAnchor,
                constant: ConstantsOfConstraint.movieDescriptionLabelTopValue
            ),
            movieDescriptionLabel.leadingAnchor.constraint(
                equalTo: movieImageView.trailingAnchor,
                constant: ConstantsOfConstraint.movieDescriptionLabelLeadingValue
            ),
            movieDescriptionLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: ConstantsOfConstraint.movieDescriptionLabelTrailingValue
            )
        ])
    }

    private func movieRatingLabelConstraint() {
        NSLayoutConstraint.activate([
            movieRatingLabel.topAnchor.constraint(
                equalTo: movieDescriptionLabel.bottomAnchor,
                constant: ConstantsOfConstraint.movieRatingLabelTopValue
            ),
            movieRatingLabel.leadingAnchor.constraint(
                equalTo: movieDescriptionLabel.leadingAnchor,
                constant: ConstantsOfConstraint.movieRatingLabelLeadingValue
            ),
            movieRatingLabel.trailingAnchor.constraint(equalTo: movieDescriptionLabel.trailingAnchor),
            movieRatingLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: ConstantsOfConstraint.movieRatingLabelTrailingValue
            )
        ])
    }
}
