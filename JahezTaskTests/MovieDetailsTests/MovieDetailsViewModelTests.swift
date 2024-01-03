//
//  MovieDetailsViewModelTests.swift
//  JahezTaskTests
//
//  Created by Eslam Salem on 03/01/2024.
//

import XCTest
import Combine
@testable import JahezTask

class MovieDetailsViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockNetworkManager: MockNetworkManager!
    private var repo: MovieDetailsDataRepository!
    private var mockInteractor: MovieDetailsInteractor!
    private var viewModel: MovieDetailsViewModel!
    let movieID = 123
    
    override func setUpWithError() throws {
        cancellables = Set<AnyCancellable>()
        mockNetworkManager = MockNetworkManager()
        repo = MovieDetailsDataRepository(networkManager: mockNetworkManager)
        mockInteractor = MovieDetailsInteractor(movieDetailsRepository: repo)
        viewModel = MovieDetailsViewModel(interactor: mockInteractor)
        setupMovieDetails()
    }

    override func tearDownWithError() throws {
        cancellables = nil
        mockNetworkManager = nil
        repo = nil
        mockInteractor = nil
        viewModel = nil
    }
    
    private func setupMovieDetails() {
        let customMovieDetails = MovieDetailsResponseModel(
            backdropPath: "/5iidzov8DrsSyZdefeo7jBLDNUW.jpg",
            budget: 50000000,
            genres: [MovieGenre(id: 1, name: "Action"), MovieGenre(id: 12, name: "Comedy")],
            homepage: "http://www.customhomepage.com",
            id: 123456,
            originalTitle: "Custom Original Title",
            overview: "This is a custom overview for the movie.",
            posterPath: "/rNQompSTfAG5O2iXSH8Phay4L45.jpg",
            spokenLanguages: [SpokenLanguage(englishName: "English"), SpokenLanguage(englishName: "Arabic")],
            status: "Custom Status",
            revenue: 100000000,
            runtime: 150,
            releaseDate: "2023-05-21"
        )
        viewModel.movieDetails = customMovieDetails
    }

    func testIsFetchingMoviesBool() {
        // simulate any response it doesn't matter respons in this case
        mockNetworkManager.responseData = "".data(using: .utf8)!

        XCTAssertFalse(viewModel.isFetchingData)
        viewModel.fetchMovieDetails(id: movieID)
        XCTAssertTrue(viewModel.isFetchingData)
    }
    
    func testGenreNames() {
        let result = viewModel.genereNames

        XCTAssertEqual(result, "Action, Comedy")
    }

    func testMovieLanguages() {
        let result = viewModel.movieLanguages
        XCTAssertEqual(result, "English, Arabic")
    }

    func testFormatReleaseData() {
        let result = viewModel.formatReleaseData()

        XCTAssertEqual(result, "2023-05")
    }
}
