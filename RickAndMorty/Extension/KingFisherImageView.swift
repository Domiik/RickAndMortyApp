//
//  KingFisherImageView.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI
import Kingfisher


@ViewBuilder
func KingFisherImageView(urlString: String) ->  KFImage {
    let url = URL(string: urlString)
    let cache = ImageCache.default
    
    // Предварительная загрузка изображения
    KFImage(url)
        .onSuccess { result in
            // Кеширование изображения
            cache.store(result.image, forKey: urlString)
        }
        .onFailure { error in

        }
        .placeholder {
            // Плейсхолдер, отображаемый, пока изображение загружается
            Image(asset: .placeholder)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
}
