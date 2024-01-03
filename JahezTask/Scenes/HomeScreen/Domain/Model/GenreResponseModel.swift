//
//  GenreResponseModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Foundation

struct MovieGenre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [MovieGenre]
}
