// MoviesRouterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол роутера экрана фильмов
protocol MoviesRouterProtocol: BaseRouter {
    func initialViewController()
    func popToRoot()
    func showDetail(id: Int)
}
