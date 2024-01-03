//
//  MovieDataRepository.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine
import Reachability
import Foundation

class MovieDataRepository: MovieRepository {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func getMovieGenres() -> AnyPublisher<GenreResponse, NetworkError> {
        let endpoint = Endpoint(path: "genre/movie/list", method: .get)
        if let reachability = try? Reachability(), reachability.connection == .unavailable {
            return JsonFilesLoader.loadOfflineData(fileName: "MockedMovieGeners")
        } else {
            return networkManager.request(endpoint)
        }
    }
    
    func getPopularMovies(page: Int, requestContext: RequestContext) -> AnyPublisher<MoviesResponseModel, NetworkError> {
        let endpoint = Endpoint(
            path: "discover/movie?include_adult=false&sort_by=popularity.desc&page=\(page)",
            method: .get
        )
        if let reachability = try? Reachability(), reachability.connection == .unavailable, requestContext == .initalCall {
            return JsonFilesLoader.loadOfflineData(fileName: "MockedMoviesList")
        } else {
            return networkManager.request(endpoint)
        }
    }
}

