//
//  MovieDetailsResponseModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import Foundation

struct MovieDetailsResponseModel: Decodable {
    let backdropPath: String?
    let budget: Int?
    let genres: [MovieGenre]?
    let homepage: String?
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let revenue: Int?
    let runtime: Int?
    let releaseDate: String?
}

struct SpokenLanguage: Decodable {
    let englishName: String?
}
