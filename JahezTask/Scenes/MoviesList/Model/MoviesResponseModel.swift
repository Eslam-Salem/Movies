//
//  MoviesResponseModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
}

struct MoviesResponseModel: Codable {
    let results: [Movie]
}
