//
//  ImageView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 19/08/24.
//

import SwiftUI

import Foundation
import UIKit

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?

    init(urlString: String?) {
        loadImage(urlString: urlString)
    }

    private func loadImage(urlString: String?) {
        ImageHandler.shared.loadImage(urlString: urlString) { [weak self] loadedImage in
            self?.image = loadedImage
        }
    }
}
