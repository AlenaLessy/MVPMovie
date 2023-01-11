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
    }

    private enum SystemImageName {
        static let clock = "clock"
        static let starFill = "star.fill"
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
        collectionView.contentInset.left = 20
        collectionView.contentInset.right = 20
        collectionView.contentInset.top = 40
        collectionView.contentInset.bottom = 20
        return collectionView
    }()

    // MARK: - Private Outlets

    private var relatedMoviesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.relatedMoviesLabelText
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
        view.layer.cornerRadius = 20
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
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.releaseDateLabelText
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var currentCountryIssueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.descriptionLabelText
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private var currentReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
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

    func configure(_ movie: MovieDetails, networkService: NetworkServiceProtocol) {
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
        ratingLabel.text = movie.rating.description
        currentReleaseDateLabel.text = movie.releaseDate
        currentTimeLabel.text = "\(movie.runtime.description) мин"
        guard let countriesName = movie.productionCountries.first
        else { return }
        currentCountryIssueLabel.text = countriesName
        fetchImage(networkService: networkService, urlString: movie.posterPath)
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
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            movieNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieNameLabel.widthAnchor.constraint(equalToConstant: 400)
        ])
    }

    private func movieImageViewConstrains() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 15),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 280),
            movieImageView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }

    private func backgroundDescriptionViewConstrains() {
        NSLayoutConstraint.activate([
            backgroundDescriptionView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -5),
            backgroundDescriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundDescriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundDescriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func countryIssueLabelConstrains() {
        NSLayoutConstraint.activate([
            countryIssueLabel.topAnchor.constraint(equalTo: backgroundDescriptionView.topAnchor, constant: 20),
            countryIssueLabel.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor, constant: 20)
        ])
    }

    private func currentCountryIssueLabelConstrains() {
        NSLayoutConstraint.activate([
            currentCountryIssueLabel.topAnchor.constraint(equalTo: countryIssueLabel.bottomAnchor, constant: 5),
            currentCountryIssueLabel.leadingAnchor.constraint(equalTo: countryIssueLabel.leadingAnchor)
        ])
    }

    private func releaseDateLabelConstrains() {
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: countryIssueLabel.topAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: countryIssueLabel.trailingAnchor, constant: 80)
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
            separationStripView.topAnchor.constraint(equalTo: currentReleaseDateLabel.bottomAnchor, constant: 20),
            separationStripView.widthAnchor.constraint(equalTo: backgroundDescriptionView.widthAnchor),
            separationStripView.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor),
            separationStripView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func timeImageViewConstrains() {
        NSLayoutConstraint.activate([
            timeImageView.topAnchor.constraint(equalTo: separationStripView.bottomAnchor, constant: 15),
            timeImageView.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor, constant: 20),
            timeImageView.heightAnchor.constraint(equalToConstant: 25),
            timeImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func currentTimeLabelConstrains() {
        NSLayoutConstraint.activate([
            currentTimeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            currentTimeLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 5)
        ])
    }

    private func ratingImageViewConstrains() {
        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: timeImageView.topAnchor),
            ratingImageView.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor),
            ratingImageView.heightAnchor.constraint(equalToConstant: 25),
            ratingImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func ratingLabelConstrains() {
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImageView.trailingAnchor, constant: 5)
        ])
    }

    private func separationStripTwoViewConstrains() {
        NSLayoutConstraint.activate([
            separationStripTwoView.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 20),
            separationStripTwoView.widthAnchor.constraint(equalTo: backgroundDescriptionView.widthAnchor),
            separationStripTwoView.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor),
            separationStripTwoView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func descriptionLabelConstrains() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: separationStripTwoView.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: countryIssueLabel.leadingAnchor)
        ])
    }

    private func movieDescriptionLabelConstrains() {
        NSLayoutConstraint.activate([
            movieDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            movieDescriptionLabel.leadingAnchor.constraint(
                equalTo: backgroundDescriptionView.leadingAnchor,
                constant: 20
            ),
            movieDescriptionLabel.trailingAnchor.constraint(
                equalTo: backgroundDescriptionView.trailingAnchor,
                constant: -20
            )
        ])
    }

    private func separationStripThreeViewConstrains() {
        NSLayoutConstraint.activate([
            separationStripThreeView.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor, constant: 20),
            separationStripThreeView.widthAnchor.constraint(equalTo: backgroundDescriptionView.widthAnchor),
            separationStripThreeView.leadingAnchor.constraint(equalTo: backgroundDescriptionView.leadingAnchor),
            separationStripThreeView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func relatedMoviesLabelConstrains() {
        NSLayoutConstraint.activate([
            relatedMoviesLabel.topAnchor.constraint(equalTo: separationStripThreeView.bottomAnchor, constant: 20),
            relatedMoviesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor)
        ])
    }

    private func collectionViewConstrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: relatedMoviesLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
