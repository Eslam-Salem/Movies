//
//  NetworkError.swift
//  JahezTask
//
//  Created by Eslam Salem on 05/01/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case noInternetConnection
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from the server"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .noInternetConnection:
            return "No internet connection"
        }
    }
}
