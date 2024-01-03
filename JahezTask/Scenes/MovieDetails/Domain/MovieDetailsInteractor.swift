//
//  MovieDetailsInteractor.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import Combine

class MovieDetailsInteractor {
    private let movieDetailsRepository: MovieDetailsRepository
    
    init(movieDetailsRepository: MovieDetailsRepository) {
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    func getMovieDetails(id: String) -> AnyPublisher<MovieDetailsResponseModel, NetworkError> {
        return movieDetailsRepository.getMovieDetails(id: id)
    }
}
