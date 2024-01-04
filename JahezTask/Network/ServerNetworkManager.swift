//
//  ServerNetworkManager.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Foundation
import Combine

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
            .mapError { error in
                NetworkError.networkError(error)
            }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    return Fail(error: .invalidResponse).eraseToAnyPublisher()
                }

                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder.defaultDecoder)
                    .mapError { error in
                        NetworkError.decodingError(error)
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
