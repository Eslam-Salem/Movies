//
//  MovieDetailsDataRepository.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import Combine

class MovieDetailsDataRepository: MovieDetailsRepository {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getMovieDetails(id: String) -> AnyPublisher<MovieDetailsResponseModel, NetworkError> {
        let endpoint = Endpoint(
            path: "movie/\(id)",
            method: .get
        )
        return networkManager.request(endpoint)
    }
}
