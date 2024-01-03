//
//  MovieDetailsRepository.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import Combine

protocol MovieDetailsRepository {
    func getMovieDetails(id: String) -> AnyPublisher<MovieDetailsResponseModel, NetworkError>
}
