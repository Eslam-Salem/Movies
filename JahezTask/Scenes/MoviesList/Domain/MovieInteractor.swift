//
//  MovieInteractor.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine

class MovieInteractor {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func getMovieGenres() -> AnyPublisher<GenreResponse, NetworkError> {
        return movieRepository.getMovieGenres()
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<MoviesResponseModel, NetworkError> {
        return movieRepository.getPopularMovies(page: page)
    }
}
