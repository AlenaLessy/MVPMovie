//
//  ViewController.swift
//  Movie
//
//  Created by Алена Панченко on 25.10.2022.
//

import UIKit

// Экран выбора фильма
final class MoviesViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let topRatedButtonTitle = "C лучшим рейтингом"
        static let popularButtonTitle = "Популярное"
        static let upCommingButtonTitle = "Скоро"
        static let urlFailureText = "urlFailure"
        static let uncnownFailureText = "Uncnown error"
        static let decodingFailureText = "decodingFailure"
        static let movieTableCellIdentifier = "MovieTableCell"
    }

    // MARK: - Private Outlets

    private var topRatedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.setTitle(Constants.topRatedButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 0
        button.accessibilityIdentifier = MovieKind.topRated.rawValue
        return button
    }()

    private var popularButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.setTitle(Constants.popularButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.cyan, for: .selected)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 0
        button.alpha = 0.5
        button.accessibilityIdentifier = MovieKind.popular.rawValue
        return button
    }()

    private var upCommingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.setTitle(Constants.upCommingButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.cyan, for: .selected)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 0
        button.alpha = 0.5
        button.accessibilityIdentifier = MovieKind.upcoming.rawValue
        return button
    }()

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        return refreshControl
    }()

    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        return tableView
    }()

    // MARK: - Private Properties

    private var movies: [Movie] = []
    private var movieDetails: MovieDetails?
    private var currentKind: MovieKind = .topRated
    private let networkService = NetworkService.shared
    private var page = 1
    private var totalPages = 1
    private var isLoading = false

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureLayoutAnchor()
        configureTableView()
        buttonConfigure()
        requestMovies(currentKind)
    }

    // MARK: - Private Actions

    @objc private func refreshControlAction() {
        page = 1
        requestMovies(currentKind)
    }

    @objc private func buttonAction(_ sender: UIButton) {
        handleChangedKind(to: sender.accessibilityIdentifier)
    }

    // MARK: - Private Methods

    private func handleChangedKind(to identifier: String?) {
        guard let identifier,
              let kind = MovieKind(rawValue: identifier)
        else { return }
        scrollToTop()
        guard currentKind != kind else { return }
        movies = []
        movieTableView.reloadData()
        page = 1
        currentKind = kind
        requestMovies(currentKind)

        UIView.animate(withDuration: 0.2) {
            self.topRatedButton.alpha = kind == .topRated ? 1 : 0.5
            self.popularButton.alpha = kind == .popular ? 1 : 0.5
            self.upCommingButton.alpha = kind == .upcoming ? 1 : 0.5
            self.view.layoutIfNeeded()
        }
    }

    private func scrollToTop() {
        movieTableView.setContentOffset(.zero, animated: true)
    }

    private func requestMovies(_ kind: MovieKind, pagination: Bool = false) {
        isLoading = true
        activityIndicatorView.startAnimating()
        page = pagination ? page + 1 : page

        networkService.requestMovies(kind: kind, page: page) { [weak self] result in
            guard let self else { return }
            self.isLoading = false

            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.refreshControl.endRefreshing()
            }

            switch result {
            case let .success(response):
                self.movies = pagination ? self.movies + response.movies : response.movies
                self.page = response.page
                self.totalPages = response.totalPages

                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            case .failure:
                break
            }
        }
    }

    private func requestMovieDetails(index: Int) {
        let movie = movies[index]
        networkService.requestMovie(id: movie.id) { [weak self] result in

            switch result {
            case .failure(.urlFailure):
                print(Constants.urlFailureText)
            case .failure(.unknown):
                print(Constants.uncnownFailureText)
            case .failure(.decodingFailure):
                print(Constants.decodingFailureText)
            case let .success(movieDetails):
                DispatchQueue.main.async {
                    let detailsMovieViewController = DetailsMovieViewController()
                    detailsMovieViewController.movieDetails = movieDetails
                    self?.navigationController?.pushViewController(detailsMovieViewController, animated: true)
                }
            }
        }
    }

    private func buttonConfigure() {
        topRatedButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        popularButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        upCommingButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    private func addSubviews() {
        let ui = [
            topRatedButton,
            popularButton,
            upCommingButton,
            movieTableView
        ].forEach { view.addSubview($0) }
        movieTableView.addSubview(activityIndicatorView)
    }

    private func configureTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieTableCellIdentifier)
    }

    // MARK: - Constrains

    private func configureLayoutAnchor() {
        topRatedButtonConstraint()
        popularButtonConstraint()
        upCommingButtonConstraint()
        movieTableViewConstraint()
        activityIndicatorViewConstraint()
    }

    private func topRatedButtonConstraint() {
        NSLayoutConstraint.activate([
            topRatedButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topRatedButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topRatedButton.heightAnchor.constraint(equalToConstant: 50),
            topRatedButton.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

    private func popularButtonConstraint() {
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: topRatedButton.topAnchor),
            popularButton.leadingAnchor.constraint(equalTo: topRatedButton.trailingAnchor, constant: 15),
            popularButton.heightAnchor.constraint(equalToConstant: 50),
            popularButton.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

    private func upCommingButtonConstraint() {
        NSLayoutConstraint.activate([
            upCommingButton.topAnchor.constraint(equalTo: topRatedButton.topAnchor),
            upCommingButton.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 15),
            upCommingButton.heightAnchor.constraint(equalToConstant: 50),
            upCommingButton.widthAnchor.constraint(equalToConstant: 110)
        ])
    }

    private func movieTableViewConstraint() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: topRatedButton.bottomAnchor, constant: 20),
            movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func activityIndicatorViewConstraint() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

/// UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableCellIdentifier)
            as? MovieTableViewCell else { return UITableViewCell() }
        cell.update(model)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree = 60
        let rotationAngel = CGFloat(Double(degree) * .pi / 180)
        let rotationPTransform = CATransform3DMakeRotation(rotationAngel, 1, 0, 0)
        cell.layer.transform = rotationPTransform
        UIView.animate(withDuration: 0.15, delay: 0.15) {
            cell.layer.transform = CATransform3DIdentity
        }

        let isLastCell = indexPath.row == movies.count - 1

        guard isLastCell, !isLoading, !movies.isEmpty else { return }
        requestMovies(currentKind, pagination: true)
    }
}

/// UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        requestMovieDetails(index: indexPath.row)
    }
}
