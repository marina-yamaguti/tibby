//
//  ImageViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 19/08/24.
//
import Foundation
import UIKit

class ImageHandler {
    static let shared = ImageHandler()

    private var imageCache: NSCache<NSString, UIImage>?

    private init() {
        imageCache = NSCache<NSString, UIImage>()
    }

    func loadImage(urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString else {
            completion(nil)
            return
        }

        if let cachedImage = getImageFromCache(from: urlString) {
            completion(cachedImage)
            return
        }

        loadImageFromURL(urlString: urlString, completion: completion)
    }

    private func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil else {
                print(error ?? "unknown error")
                completion(nil)
                return
            }

            guard let data = data, let loadedImage = UIImage(data: data) else {
                print("No data found or failed to create image")
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                self?.setImageCache(image: loadedImage, key: urlString)
                completion(loadedImage)
            }
        }.resume()
    }

    private func setImageCache(image: UIImage, key: String) {
        imageCache?.setObject(image, forKey: key as NSString)
    }

    private func getImageFromCache(from key: String) -> UIImage? {
        return imageCache?.object(forKey: key as NSString)
    }
}
