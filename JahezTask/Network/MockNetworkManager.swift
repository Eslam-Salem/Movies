//
//  MockNetworkManager.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine
import Foundation

class MockNetworkManager: NetworkManager {
    var capturedEndpoint: Endpoint?
    var responseError: Error?
    var responseData: Data?

    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        capturedEndpoint = endpoint

        if let responseError = responseError as? NetworkError {
            return Fail(error: responseError).eraseToAnyPublisher()
        }

        guard let responseData = responseData else {
            fatalError("Response data is nil. Make sure to set responseData before making the network request.")
        }

        return Just(responseData)
            .decode(type: T.self, decoder: JSONDecoder.defaultDecoder)
            .mapError { _ in NetworkError.invalidResponse }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
