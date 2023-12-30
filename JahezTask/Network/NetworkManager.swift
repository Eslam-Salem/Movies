//
//  NetworkManager.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}

struct Endpoint: Equatable {
    let path: String
    let method: HTTPMethod
}

enum HTTPMethod: String {
    case get = "GET"
    // Add more methods as needed
}

protocol NetworkManager {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

struct ServerNetworkManager: NetworkManager {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        let urlPath = Constants.baseURL + endpoint.path
        guard let url = URL(string: urlPath) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        request.allHTTPHeaderFields =
        [
            "Authorization": Constants.ApiKey
        ]

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.decodingError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
