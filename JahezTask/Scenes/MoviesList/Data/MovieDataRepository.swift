//
//  MovieDataRepository.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine

class MovieDataRepository: MovieRepository {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getMovieGenres() -> AnyPublisher<GenreResponse, NetworkError> {
        let endpoint = Endpoint(path: "genre/movie/list", method: .get)
        return networkManager.request(endpoint)
    }
}
