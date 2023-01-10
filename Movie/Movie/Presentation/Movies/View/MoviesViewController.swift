// MoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран выбора фильма
final class MoviesViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let topRatedButtonTitle = "C лучшим рейтингом"
        static let popularButtonTitle = "Популярное"
        static let upCommingButtonTitle = "Скоро"
        static let movieTableCellIdentifier = "MovieTableCell"
        static let alertTitleText = "Ой!"
        static let alertMessageText = "Произошла ошибка(("
        static let alertActionTitleText = "Ok"
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

    // MARK: - Public Properties

    var presenter: MoviesPresenterProtocol!

    // MARK: - Private Properties

    private var networkService = NetworkService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureLayoutAnchor()
        configureTableView()
        buttonConfigure()
    }

    // MARK: - Private Actions

    @objc private func refreshControlAction() {
        presenter.refreshControlAction()
    }

    @objc private func buttonAction(_ sender: UIButton) {
        presenter.handleChangedKind(to: sender.accessibilityIdentifier)
    }

    // MARK: - Private Methods

    private func buttonConfigure() {
        topRatedButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        popularButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        upCommingButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    private func addSubviews() {
        [
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
        presenter.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableCellIdentifier)
            as? MovieTableViewCell,
            let movie = presenter.movies?[indexPath.row]
        else { return UITableViewCell() }
        cell.update(movie: movie, networkService: networkService)
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
        presenter.newFetchMovies(to: indexPath.row)
    }
}

/// UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = presenter.movies?[indexPath.row].id else { return }
        presenter.tapDetailsMovie(id: movieId)
    }
}

/// MoviesViewProtocol
extension MoviesViewController: MoviesViewProtocol {
    func setupAlpha() {
        UIView.animate(withDuration: 0.2) {
            self.topRatedButton.alpha = self.presenter.topRatedButtonAlpha
            self.popularButton.alpha = self.presenter.popularButtonAlpha
            self.upCommingButton.alpha = self.presenter.upcomingButtonAlpha
            self.view.layoutIfNeeded()
        }
    }

    func reloadTableView() {
        movieTableView.reloadData()
    }

    func stopActivityIndicatorAndRefreshControl() {
        activityIndicatorView.stopAnimating()
        refreshControl.endRefreshing()
    }

    func startActivityIndicator() {
        activityIndicatorView.startAnimating()
    }

    func succes() {
        movieTableView.reloadData()
    }

    func failure() {
        showAlert(
            title: Constants.alertTitleText,
            message: Constants.alertMessageText,
            actionTitle: Constants.alertActionTitleText,
            handler: nil
        )
    }

    func scrollToTop() {
        movieTableView.setContentOffset(.zero, animated: true)
    }
}
