// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Сервис для получения фото
final class ImageService: ImageServiceProtocol {
    // MARK: - Private Properties

    private var imagesMap: [String: UIImage] = [:]
    private var fileManagerService: FileManagerServiceProtocol
    private var imageApiService: ImageApiServiceProtocol

    // MARK: - Initializers

    init(fileManagerService: FileManagerServiceProtocol, imageApiService: ImageApiServiceProtocol) {
        self.fileManagerService = fileManagerService
        self.imageApiService = imageApiService
    }

    // MARK: - Public Methods

    func fetchPhoto(byUrl url: String, completion: ((UIImage?) -> ())?) {
        if let photo = imagesMap[url] {
            completion?(photo)
        } else if let photo = fileManagerService.getImageFromCache(url: url) {
            DispatchQueue.main.async {
                self.imagesMap[url] = photo
            }
            completion?(photo)
        } else {
            imageApiService.fetchPhoto(byUrl: url) { [weak self] image in
                guard let image,
                      let self
                else { return }
                DispatchQueue.main.async {
                    self.imagesMap[url] = image
                }
                self.fileManagerService.saveImageToCache(url: url, image: image)
                completion?(image)
            }
        }
    }
}
