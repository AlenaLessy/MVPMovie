// DetailsMovieViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Выход экрана деталей фильма
protocol DetailsMovieViewProtocol: AnyObject {
    func reloadTableView()
    func reloadCollectionView()
    func failure()
}
