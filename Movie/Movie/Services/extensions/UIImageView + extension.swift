//
//  extention + ImageView.swift
//  Movie
//
//  Created by Алена Панченко on 26.10.2022.
//

import UIKit
// Расширение для добавления картинки из интернета
extension UIImageView {
    func loadImage(urlImage: String) {
        image = nil
        let imageUrl = "https://image.tmdb.org/t/p/w500\(urlImage)"
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let self else { return }
                DispatchQueue.main.async {
                    if let data {
                        if let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}
