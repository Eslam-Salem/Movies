//
//  NetworkManager.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case noInternetConnection
}

struct Endpoint: Equatable {
    let path: String
    let method: HTTPMethod
}

enum HTTPMethod: String {
    case get = "GET"
    // Add more methods as needed
}

enum RequestContext {
    case initalCall
    case pagination
}

protocol NetworkManager {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}
