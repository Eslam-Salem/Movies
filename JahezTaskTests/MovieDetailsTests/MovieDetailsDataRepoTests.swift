//
//  MovieDetailsDataRepoTests.swift
//  JahezTaskTests
//
//  Created by Eslam Salem on 03/01/2024.
//

import XCTest
import Combine
@testable import JahezTask

class MovieDetailsDataRepositoryTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var mockNetworkManager: MockNetworkManager!
    var dataRepository: MovieDetailsDataRepository!

    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        dataRepository = MovieDetailsDataRepository(networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        dataRepository = nil
        mockNetworkManager = nil
    }

    func testGetMovieDetailsSuccess() {
        let movieID = "123"
        let expectedResult = """
        {
            "backdrop_path": "/jXJxMcVoEuXzym3vFnjqDW4ifo6.jpg",
            "budget": 205000000,
            "genres": [
                {
                    "id": 28,
                    "name": "Action"
                },
                {
                    "id": 12,
                    "name": "Adventure"
                },
                {
                    "id": 14,
                    "name": "Fantasy"
                }
            ],
            "homepage": "http://www.aquamanmovie.com",
            "id": 572802,
            "original_title": "Aquaman and the Lost Kingdom",
            "overview": "Black Manta, still driven by the need to avenge his father's death and wielding the power of the mythic Black Trident, will stop at nothing to take Aquaman down once and for all. To defeat him, Aquaman must turn to his imprisoned brother Orm, the former King of Atlantis, to forge an unlikely alliance in order to save the world from irreversible destruction.",
            "poster_path": "/8xV47NDrjdZDpkVcCFqkdHa3T0C.jpg",
            "release_date": "2023-12-20",
            "revenue": 255400000,
            "runtime": 124,
            "spoken_languages": [
                {
                    "english_name": "English",
                    "iso_639_1": "en",
                    "name": "English"
                },
                {
                    "english_name": "Hungarian",
                    "iso_639_1": "hu",
                    "name": "Magyar"
                }
            ],
            "status": "Released",
            "tagline": "The tide is turning.",
            "title": "Aquaman and the Lost Kingdom"
        }
        """.data(using: .utf8)!
        mockNetworkManager.responseData = expectedResult

        let expectation = XCTestExpectation(description: "Fetch movie details")
        var receivedResult: MovieDetailsResponseModel?

        dataRepository.getMovieDetails(id: movieID)
            .sink { completion in
                switch completion {
                case .finished:
                    break // Do nothing, successful completion
                case .failure(let error):
                    XCTFail("Unexpected error: \(error)")
                }
                expectation.fulfill()
            } receiveValue: { result in
                receivedResult = result
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(mockNetworkManager.capturedEndpoint?.path, "movie/\(movieID)")
        XCTAssertEqual(receivedResult?.id, 572802)
        XCTAssertEqual(receivedResult?.originalTitle, "Aquaman and the Lost Kingdom")
    }
}
