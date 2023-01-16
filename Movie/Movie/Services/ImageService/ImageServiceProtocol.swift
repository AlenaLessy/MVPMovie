// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для загрузки и кеширования изображений
protocol ImageServiceProtocol {
    func fetchPhoto(byUrl url: String, completion: ((UIImage?) -> ())?)
}
