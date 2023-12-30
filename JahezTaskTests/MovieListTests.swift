//
//  MovieListTests.swift
//  JahezTaskTests
//
//  Created by Eslam Salem on 30/12/2023.
//

import XCTest
import Combine
@testable import JahezTask

class MovieListTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var movieDataRepository: MovieDataRepository!

    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        movieDataRepository = MovieDataRepository(networkManager: mockNetworkManager)
    }

    func testGetMovieGenres() {
        // Given
        let expectedEndpoint = Endpoint(path: "genre/movie/list", method: .get)
        let responseData = """
            {
                "genres": [
                    {"id": 1, "name": "Action"},
                    {"id": 2, "name": "Drama"}
                ]
            }
        """.data(using: .utf8)!
        mockNetworkManager.responseData = responseData

        // When
        var receivedGenres: [MovieGenre]?
        let expectation = self.expectation(description: "Expect to receive genres")

        let cancellable = movieDataRepository.getMovieGenres()
            .sink(receiveCompletion: { _ in }) { genres in
                receivedGenres = genres.genres
                expectation.fulfill()
            }

        waitForExpectations(timeout: 1, handler: nil)
        cancellable.cancel()

        // Then
        XCTAssertEqual(mockNetworkManager.capturedEndpoint, expectedEndpoint)
        XCTAssertEqual(receivedGenres?.count, 2)
        XCTAssertEqual(receivedGenres?[0].name, "Action")
        XCTAssertEqual(receivedGenres?[1].name, "Drama")
    }
}
