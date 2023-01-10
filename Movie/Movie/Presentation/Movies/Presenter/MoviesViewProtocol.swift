// MoviesViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Выход экрана выбора фильмов
protocol MoviesViewProtocol: AnyObject {
    func reloadTableView()
    func failure()
    func startActivityIndicator()
    func stopActivityIndicatorAndRefreshControl()
    func scrollToTop()
    func setupAlpha()
}
