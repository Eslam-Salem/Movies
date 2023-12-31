//
//  ImageLoader.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    
    func downloadImage(path: String) {
        guard let imageURL = URL(string: Constants.imageBaseURL + path) else { return }
        var request = URLRequest(url: imageURL)
        request.allHTTPHeaderFields =
        [
            "Authorization": Constants.ApiKey
        ]
        cancellable = URLSession.shared.dataTaskPublisher(for: imageURL)
            .map(\.data)
            .receive(on: DispatchQueue.main) // Ensure UI updates are on the main thread
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] data in
                if let uiImage = UIImage(data: data) {
                    self?.image = uiImage
                }
            })
    }
}
