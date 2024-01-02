//
//  MovieDataRepositoryTests.swift
//  JahezTaskTests
//
//  Created by Eslam Salem on 02/01/2024.
//

import XCTest
@testable import JahezTask

class MovieDataRepositoryTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var movieDataRepository: MovieDataRepository!

    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        movieDataRepository = MovieDataRepository(networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        movieDataRepository = nil
        mockNetworkManager = nil
    }

    func testGetMovieGenres() {
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

        var receivedGenres: [MovieGenre]?
        let expectation = self.expectation(description: "Expect to receive genres")

        let cancellable = movieDataRepository.getMovieGenres()
            .sink(receiveCompletion: { _ in }) { genres in
                receivedGenres = genres.genres
                expectation.fulfill()
            }

        waitForExpectations(timeout: 1, handler: nil)
        cancellable.cancel()

        XCTAssertEqual(mockNetworkManager.capturedEndpoint, expectedEndpoint)
        XCTAssertEqual(receivedGenres?.count, 2)
        XCTAssertEqual(receivedGenres?[0].name, "Action")
        XCTAssertEqual(receivedGenres?[1].name, "Drama")
    }
    
    func testGetPopularMovies() {
        let page = 1
        let expectedEndpoint = Endpoint(
            path: "discover/movie?include_adult=false&sort_by=popularity.desc&page=\(page)",
            method: .get
        )
        let responseData = """
            {
                "results": [
                    {"id": 1, "title": "Movie 1", "genre_ids": [1, 2]},
                    {"id": 2, "title": "Movie 2", "genre_ids": [2, 3]}
                ],
                "total_pages": 2
            }
        """.data(using: .utf8)!
        mockNetworkManager.responseData = responseData

        var receivedMovies: [Movie]?
        let expectation = self.expectation(description: "Expect to receive movies")

        let cancellable = movieDataRepository.getPopularMovies(page: page)
            .sink(receiveCompletion: { _ in }) { movies in
                receivedMovies = movies.results
                expectation.fulfill()
            }

        waitForExpectations(timeout: 1, handler: nil)
        cancellable.cancel()

        XCTAssertEqual(mockNetworkManager.capturedEndpoint, expectedEndpoint)
        XCTAssertEqual(receivedMovies?.count, 2)
        XCTAssertEqual(receivedMovies?[0].title, "Movie 1")
        XCTAssertEqual(receivedMovies?[1].title, "Movie 2")
        XCTAssertEqual(receivedMovies?[0].genreIds, [1, 2])
        XCTAssertEqual(receivedMovies?[1].genreIds, [2, 3])
        XCTAssertEqual(receivedMovies?[0].id, 1)
        XCTAssertEqual(receivedMovies?[1].id, 2)
        XCTAssertEqual(mockNetworkManager.capturedEndpoint, expectedEndpoint)
    }
}
