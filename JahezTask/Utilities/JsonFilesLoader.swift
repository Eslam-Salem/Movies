//
//  JsonFilesLoader.swift
//  JahezTask
//
//  Created by Eslam Salem on 03/01/2024.
//

import Foundation
import Combine

class JsonFilesLoader {
    static func loadOfflineData<T: Decodable>(fileName: String) -> AnyPublisher<T, NetworkError> {
        if let offlineData: T = JsonFilesLoader.readDataFrom(fileName: fileName) {
            return Just(offlineData)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: .noInternetConnection).eraseToAnyPublisher()
        }
    }
    
    private static func readDataFrom<T: Decodable>(fileName: String) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            return try? JSONDecoder.defaultDecoder.decode(T.self, from: data)
        }
        return nil
    }
}
