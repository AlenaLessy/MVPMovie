// ImageApiService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Протокол для скачивания фото из интернета
protocol ImageApiServiceProtocol {
    func fetchPhoto(byUrl url: String, completion: ((UIImage?) -> ())?)
}

/// Сервис для скачивания фото
final class ImageApiService: ImageApiServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let baseImageIRLString = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Public Methods

    func fetchPhoto(byUrl url: String, completion: ((UIImage?) -> ())?) {
        let imageUrl = "\(Constants.baseImageIRLString)\(url)"
        AF.request(imageUrl).responseData(queue: DispatchQueue.global()) { response in
            guard let data = response.data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion?(image)
            }
        }
    }
}
