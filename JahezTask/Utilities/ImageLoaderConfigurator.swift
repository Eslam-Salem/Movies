//
//  ImageLoaderConfigurator.swift
//  JahezTask
//
//  Created by Eslam Salem on 31/12/2023.
//

import Kingfisher

class ImageLoaderConfigurator {
    static let shared = ImageLoaderConfigurator()

    private init() {}

    func configureDownloader() {
        let modifier = AnyModifier { request in
            var request = request
            request.setValue(Constants.ApiKey, forHTTPHeaderField: "Authorization")
            return request
        }

        let options = KingfisherOptionsInfo(
            [.requestModifier(modifier)]
        )

        KingfisherManager.shared.defaultOptions = options
    }
}
