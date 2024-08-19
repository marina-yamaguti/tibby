//
//  ImageView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 19/08/24.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject private var imageViewModel: ImageViewModel

    init(urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString)
    }

    var body: some View {
        Image(uiImage: imageViewModel.image ?? UIImage())
            .resizable()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinEating2.png")
    }
}
