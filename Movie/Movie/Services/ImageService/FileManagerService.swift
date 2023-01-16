// FileManagerService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Протокол кеширования фото
protocol FileManagerServiceProtocol {
    func saveImageToCache(url: String, image: UIImage)
    func getImageFromCache(url: String) -> UIImage?
}

/// Сервис для кеширования фото
final class FileManagerService: FileManagerServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let pathName = "images"
        static let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
        static let slash: Character = "/"
    }

    // MARK: - Private Properties

    private let cacheLifeTime: TimeInterval = Constants.cacheLifeTime

    private static let pathName: String = {
        let pathName = Constants.pathName
        guard let cachesDirectory = FileManager.default.urls(
            for:
            .cachesDirectory,
            in: .userDomainMask
        ).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(
            pathName,
            isDirectory:
            true
        )
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    private var imagesMap: [String: UIImage] = [:]

    // MARK: - Public Methods

    func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName)
        else { return nil
        }
        return image
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
              let hashName = url.split(separator: Constants.slash).last
        else { return nil }
        return cachesDirectory.appendingPathComponent("\(FileManagerService.pathName)\(Constants.slash)\(hashName)")
            .path
    }
}
