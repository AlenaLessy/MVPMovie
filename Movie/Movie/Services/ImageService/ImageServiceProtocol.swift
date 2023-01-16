// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сервиса изображений
protocol ImageServiceProtocol {
    func fetchPhoto(byUrl url: String, completion: ((Data?) -> ())?)
}
