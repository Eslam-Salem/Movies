//
//  MoviesResponseModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String?
    let posterPath: String?
    let releaseDate: String?
    let genreIds: [Int]?
}

struct MoviesResponseModel: Codable {
    let results: [Movie]?
    let totalPages: Int?
}
