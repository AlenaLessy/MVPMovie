// DetailsMovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка деталей фильма
final class DetailsMovieTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let detailsViewColorName = "detailsViewColor"
        static let separationStripColorName = "separationStripColor"
        static let relatedMoviesLabelText = "Похожие фильмы:"
        static let countryIssueLabelText = "Страна выпуска:"
        static let releaseDateLabelText = "Дата выпуска:"
        static let descriptionLabelText = "Описание:"
        static let relatedCollectionViewCellIdentifier = "Relate"
        static let collectionViewLeftContentInsertValue = 20
        static let collectionViewContentInsetLeftValue: CGFloat = 20
        static let collectionViewContentInsetRightValue: CGFloat = 20
        static let collectionViewContentInsetTopValue: CGFloat = 40
        static let collectionViewContentInsetBottomValue: CGFloat = 20
        static let relatedMoviesLabelFontSize: CGFloat = 16
        static let backgroundDescriptionViewCornerRadius: CGFloat = 20
        static let countryIssueLabelFontSize: CGFloat = 16
        static let releaseDateLabelFontSize: CGFloat = 16
        static let currentCountryIssueLabelFontSize: CGFloat = 16
        static let currentTimeLabelFontSize: CGFloat = 16
        static let ratingLabelFontSize: CGFloat = 18
        static let descriptionLabelFontSize: CGFloat = 16
        static let currentReleaseDateLabelFontSize: CGFloat = 16
        static let movieNameLabelFontSize: CGFloat = 20
        static let movieDescriptionLabelFontSize: CGFloat = 16
        static let movieDescriptionLabelNumberOfLinesValue = 0
    }

    private enum SystemImageName {
        static let clock = "clock"
        static let starFill = "star.fill"
    }

    private enum Constraint {
        static let movieNameLabelTopValue: CGFloat = 20
        static let movieNameLabelWidthValue: CGFloat = 400
        static let movieImageViewTopValue: CGFloat = 15
        static let movieImageViewWidthValue: CGFloat = 280
        static let movieImageViewHeightValue: CGFloat = 280
        static let backgroundDescriptionViewTopValue: CGFloat = -5
        static let countryIssueLabelTopValue: CGFloat = 20
        static let countryIssueLabelLeadingValue: CGFloat = 20
        static let currentCountryIssueLabelTopValue: CGFloat = 5
        static let releaseDateLabelLeadingValue: CGFloat = 80
        static let separationStripViewLeadingValue: CGFloat = 20
        static let separationStripViewHeightValue: CGFloat = 1
        static let timeImageViewTopValue: CGFloat = 15
        static let timeImageViewLeadingValue: CGFloat = 20
        static let timeImageViewWidthValue: CGFloat = 25
        static let timeImageViewHeightValue: CGFloat = 25
        static let currentTimeLabelLeadingValue: CGFloat = 5
        static let ratingImageViewWidthValue: CGFloat = 25
        static let ratingImageViewHeightValue: CGFloat = 25
        static let ratingLabelLeadingValue: CGFloat = 5
        static let descriptionLabelTopValue: CGFloat = 20
        static let movieDescriptionLabelLeadingValue: CGFloat = 20
        static let movieDescriptionLabelTrailingValue: CGFloat = -20
        static let relatedMoviesLabelTopValue: CGFloat = 20
        static let collectionViewHeightValue: CGFloat = 200
    }

    // MARK: - Public Outlets

    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            RelatedMoviesCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.relatedCollectionViewCellIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: Constants.detailsViewColorName)
        collectionView.contentInset.left = Constants.collectionViewContentInsetLeftValue
        collectionView.contentInset.right = Constants.collectionViewContentInsetRightValue
        collectionView.contentInset.top = Constants.collectionViewContentInsetTopValue
        collectionView.contentInset.bottom = Constants.collectionViewContentInsetBottomValue
        return collectionView
    }()

    // MARK: - Private Outlets

    private var relatedMoviesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.relatedMoviesLabelText
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.relatedMoviesLabelFontSize, weight: .bold)
        return label
    }()

    private var movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .center
        return image
    }()

    private var timeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: SystemImageName.clock)
        image.tintColor = .white
        return image
    }()

    private var ratingImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: SystemImageName.starFill)
        image.tintColor = .white
        return image
    }()

    private var backgroundDescriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.detailsViewColorName)
        view.layer.cornerRadius = Constants.backgroundDescriptionViewCornerRadius
        return view
    }()

    private var separationStripView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.separationStripColorName)
        return view
    }()

    private var separationStripTwoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.separationStripColorName)
        return view
    }()

    private var separationStripThreeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.separationStripColorName)
        return view
    }()

    private var countryIssueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.countryIssueLabelText
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.countryIssueLabelFontSize, weight: .bold)
        return label
    }()

    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.releaseDateLabelText
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.releaseDateLabelFontSize, weight: .bold)
        return label
    }()

    private var currentCountryIssueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.currentCountryIssueLabelFontSize, weight: .semibold)
        return label
    }()

    private var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.currentTimeLabelFontSize, weight: .semibold)
        return label
    }()

    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.ratingLabelFontSize, weight: .semibold)
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.descriptionLabelText
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.descriptionLabelFontSize, weight: .bold)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private var currentReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.currentReleaseDateLabelFontSize, weight: .semibold)
        return label
    }()

    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: Constants.movieNameLabelFontSize, weight: .bold)
        return label
    }()

    private var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: Constants.movieDescriptionLabelFontSize)
        label.numberOfLines = Constants.movieDescriptionLabelNumberOfLinesValue
        label.sizeToFit()
        return label
    }()

    // MARK: - LifeCycle

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

    override func prepareForReuse() {
        super.prepareForReuse()
        movieNameLabel.text = nil
        movieDescriptionLabel.text = nil
        ratingLabel.text = nil
        currentReleaseDateLabel.text = nil
        currentTimeLabel.text = nil
        movieImageView.image = nil
    }

    func configure(_ movie: MovieDetails, imageService: ImageServiceProtocol) {
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
        ratingLabel.text = movie.rating.description
        currentReleaseDateLabel.text = movie.releaseDate
        currentTimeLabel.text = "\(movie.runtime.description) мин"
        fetchImage(imageService: imageService, urlString: movie.posterPath)
        guard let countriesName = movie.productionCountries.first
        else { return }
        currentCountryIssueLabel.text = countriesName
        //  fetchImage(networkService: networkService, urlString: movie.posterPath)
    }

    // MARK: - Private Methods

    private func addSubviews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(backgroundDescriptionView)
        backgroundDescriptionView.addSubview(countryIssueLabel)
        backgroundDescriptionView.addSubview(currentCountryIssueLabel)
        backgroundDescriptionView.addSubview(releaseDateLabel)
        backgroundDescriptionView.addSubview(currentReleaseDateLabel)
        backgroundDescriptionView.addSubview(separationStripView)
        backgroundDescriptionView.addSubview(timeImageView)
        backgroundDescriptionView.addSubview(currentTimeLabel)
        backgroundDescriptionView.addSubview(ratingImageView)
        backgroundDescriptionView.addSubview(ratingLabel)
        backgroundDescriptionView.addSubview(separationStripTwoView)
        backgroundDescriptionView.addSubview(descriptionLabel)
        backgroundDescriptionView.addSubview(movieDescriptionLabel)
        backgroundDescriptionView.addSubview(separationStripThreeView)
        backgroundDescriptionView.addSubview(relatedMoviesLabel)
        backgroundDescriptionView.addSubview(collectionView)
    }

    private func fetchImage(imageService: ImageServiceProtocol, urlString: String) {
        imageService.fetchPhoto(byUrl: urlString) { [weak self] image in
            self?.movieImageView.image = image
        }
//        guard let image = imageService.photo(byUrl: urlString) else { return }
//        movieImageView.image = image
//        reloadInputViews()

//        networkService.fetchImage(imageUrlPath: urlString) { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case let .success(data):
//                DispatchQueue.main.async {
//                    self.movieImageView.image = UIImage(data: data)
//                }
//            case .failure:
//                print(NetworkError.unknown.description)
//            }
//        }
    }

    // MARK: - Constrains

    private func configureLayoutAnchor() {
        movieNameLabelConstrains()
        movieImageViewConstrains()
        backgroundDescriptionViewConstrains()
        countryIssueLabelConstrains()
        currentCountryIssueLabelConstrains()
        releaseDateLabelConstrains()
        currentReleaseDateLabelConstrains()
        separationStripViewConstrains()
        timeImageViewConstrains()
        currentTimeLabelConstrains()
        ratingImageViewConstrains()
        ratingLabelConstrains()
        separationStripTwoViewConstrains()
        descriptionLabelConstrains()
        movieDescriptionLabelConstrains()
        separationStripThreeViewConstrains()
        relatedMoviesLabelConstrains()
        collectionViewConstrains()
    }

    private func movieNameLabelConstrains() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constraint.movieNameLabelTopValue
            ),
            movieNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieNameLabel.widthAnchor.constraint(equalToConstant: Constraint.movieNameLabelWidthValue)
        ])
    }

    private func movieImageViewConstrains() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(
                equalTo: movieNameLabel.bottomAnchor,
                constant: Constraint.movieImageViewTopValue
            ),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: Constraint.movieImageViewHeightValue),
            movieImageView.widthAnchor.constraint(equalToConstant: Constraint.movieImageViewWidthValue)
        ])
    }

    private func backgroundDescriptionViewConstrains() {
        NSLayoutConstraint.activate([
            backgroundDescriptionView.topAnchor.constraint(
                equalTo: movieImageView.bottomAnchor,
                constant: Constraint.backgroundDescriptionViewTopValue
            ),
            backgroundDescriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundDescriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundDescriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func countryIssueLabelConstrains() {
        NSLayoutConstraint.activate([
            countryIssueLabel.topAnchor.constraint(
                equalTo: backgroundDescriptionView.topAnchor,
                constant: Constraint.countryIssueLabelTopValue
            ),
            countryIssueLabel.leadingAnchor.constraint(
                equalTo: backgroundDescriptionView.leadingAnchor,
                constant: Constraint.countryIssueLabelLeadingValue
            )
        ])
    }

    private func currentCountryIssueLabelConstrains() {
        NSLayoutConstraint.activate([
            currentCountryIssueLabel.topAnchor.constraint(
                equalTo: countryIssueLabel.bottomAnchor,
                constant: Constraint.currentCountryIssueLabelTopValue
            ),
            currentCountryIssueLabel.leadingAnchor.constraint(equalTo: countryIssueLabel.leadingAnchor)
        ])
    }

    private func releaseDateLabelConstrains() {
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: countryIssueLabel.topAnchor),
            releaseDateLabel.leadingAnchor.constraint(
                equalTo: countryIssueLabel.trailingAnchor,
                constant: Constraint.releaseDateLabelLeadingValue
            )
        ])
    }

    private func currentReleaseDateLabelConstrains() {
        NSLayoutConstraint.activate([
            currentReleaseDateLabel.topAnchor.constraint(equalTo: currentCountryIssueLabel.topAnchor),
            currentReleaseDateLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor)
        ])
    }

    private func separationStripViewConstrains() {
        NSLayoutConstraint.activate([
            separationStripView.topAnchor.constraint(
                equalTo: currentReleaseDateLabel.bottomAnchor,
                constant: Constraint.separationStripViewLeadingValue
            ),
            separationStripView.widthAnchor.constraint(equalTo: backgroundDescriptionView.widthAnchor),
            separationStripView.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor),
            separationStripView.heightAnchor.constraint(equalToConstant: Constraint.separationStripViewHeightValue)
        ])
    }

    private func timeImageViewConstrains() {
        NSLayoutConstraint.activate([
            timeImageView.topAnchor.constraint(
                equalTo: separationStripView.bottomAnchor,
                constant: Constraint.timeImageViewTopValue
            ),
            timeImageView.leadingAnchor.constraint(
                equalTo: backgroundDescriptionView.leadingAnchor,
                constant: Constraint.timeImageViewLeadingValue
            ),
            timeImageView.heightAnchor.constraint(equalToConstant: Constraint.timeImageViewHeightValue),
            timeImageView.widthAnchor.constraint(equalToConstant: Constraint.timeImageViewWidthValue)
        ])
    }

    private func currentTimeLabelConstrains() {
        NSLayoutConstraint.activate([
            currentTimeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            currentTimeLabel.leadingAnchor.constraint(
                equalTo: timeImageView.trailingAnchor,
                constant: Constraint.currentTimeLabelLeadingValue
            )
        ])
    }

    private func ratingImageViewConstrains() {
        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: timeImageView.topAnchor),
            ratingImageView.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor),
            ratingImageView.heightAnchor.constraint(equalToConstant: Constraint.ratingImageViewHeightValue),
            ratingImageView.widthAnchor.constraint(equalToConstant: Constraint.ratingImageViewWidthValue)
        ])
    }

    private func ratingLabelConstrains() {
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(
                equalTo: ratingImageView.trailingAnchor,
                constant: Constraint.ratingLabelLeadingValue
            )
        ])
    }

    private func separationStripTwoViewConstrains() {
        NSLayoutConstraint.activate([
            separationStripTwoView.topAnchor.constraint(
                equalTo: currentTimeLabel.bottomAnchor,
                constant: Constraint.separationStripViewLeadingValue
            ),
            separationStripTwoView.widthAnchor.constraint(equalTo: backgroundDescriptionView.widthAnchor),
            separationStripTwoView.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor),
            separationStripTwoView.heightAnchor.constraint(equalToConstant: Constraint.separationStripViewHeightValue)
        ])
    }

    private func descriptionLabelConstrains() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(
                equalTo: separationStripTwoView.topAnchor,
                constant: Constraint.descriptionLabelTopValue
            ),
            descriptionLabel.leadingAnchor.constraint(equalTo: countryIssueLabel.leadingAnchor)
        ])
    }

    private func movieDescriptionLabelConstrains() {
        NSLayoutConstraint.activate([
            movieDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            movieDescriptionLabel.leadingAnchor.constraint(
                equalTo: backgroundDescriptionView.leadingAnchor,
                constant: Constraint.movieDescriptionLabelLeadingValue
            ),
            movieDescriptionLabel.trailingAnchor.constraint(
                equalTo: backgroundDescriptionView.trailingAnchor,
                constant: Constraint.movieDescriptionLabelTrailingValue
            )
        ])
    }

    private func separationStripThreeViewConstrains() {
        NSLayoutConstraint.activate([
            separationStripThreeView.topAnchor.constraint(
                equalTo: movieDescriptionLabel.bottomAnchor,
                constant: Constraint.separationStripViewLeadingValue
            ),
            separationStripThreeView.widthAnchor.constraint(equalTo: backgroundDescriptionView.widthAnchor),
            separationStripThreeView.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor),
            separationStripThreeView.heightAnchor.constraint(equalToConstant: Constraint.separationStripViewHeightValue)
        ])
    }

    private func relatedMoviesLabelConstrains() {
        NSLayoutConstraint.activate([
            relatedMoviesLabel.topAnchor.constraint(
                equalTo: separationStripThreeView.bottomAnchor,
                constant: Constraint.relatedMoviesLabelTopValue
            ),
            relatedMoviesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor)
        ])
    }

    private func collectionViewConstrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: relatedMoviesLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Constraint.collectionViewHeightValue),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
