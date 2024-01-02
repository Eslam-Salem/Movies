//
//  HomeScreenViewModelTests.swift
//  JahezTaskTests
//
//  Created by Eslam Salem on 30/12/2023.
//

import XCTest
import Combine
@testable import JahezTask

class HomeScreenViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockNetworkManager: MockNetworkManager!
    private var repo: MovieDataRepository!
    private var mockInteractor: MovieInteractor!
    private var viewModel: HomeScreenViewModel!

    override func setUpWithError() throws {
        cancellables = Set<AnyCancellable>()
        mockNetworkManager = MockNetworkManager()
        repo = MovieDataRepository(networkManager: mockNetworkManager)
        mockInteractor = MovieInteractor(movieRepository: repo)
        viewModel = HomeScreenViewModel(movieInteractor: mockInteractor)
    }

    override func tearDownWithError() throws {
        cancellables = nil
        mockNetworkManager = nil
        repo = nil
        mockInteractor = nil
        viewModel = nil
    }

    func testFilterMovies() {
        // Assuming you have genres and movies loaded
        viewModel.genres = [MovieGenre(id: 1, name: "Action"), MovieGenre(id: 2, name: "Comedy")]
        viewModel.allMovies = [
            Movie(id: 1, title: "Movie1", posterPath: "", releaseDate: "2023-01-01", genreIds: [1]),
            Movie(id: 2, title: "Movie2", posterPath: "", releaseDate: "2023-01-02", genreIds: [2]),
        ]

        let searchText = "Movie1"
        let selectedGenres: Set<Int> = [1]

        viewModel.filterMovies(selectedGenres: selectedGenres, searchText: searchText)

        XCTAssertEqual(viewModel.filterdMovies.count, 1)
        XCTAssertEqual(viewModel.filterdMovies.first?.title, "Movie1")
    }

    func testLoadMoreMoviesIfNeeded() {
        viewModel.allMovies = [
            Movie(id: 1, title: "Movie1", posterPath: "", releaseDate: "2023-01-01", genreIds: [1]),
            Movie(id: 2, title: "Movie2", posterPath: "", releaseDate: "2023-01-02", genreIds: [2]),
        ]
        viewModel.currentPage = 1
        viewModel.totalNumberOfPages = 2

        // simulate any response. it doesn't matter respons in this case
        mockNetworkManager.responseData = "".data(using: .utf8)!

        XCTAssertFalse(viewModel.isFetchingNextPage)
        viewModel.loadMoreMoviesIfNeeded(movie: viewModel.allMovies.last!)
        XCTAssertTrue(viewModel.isFetchingNextPage)
        XCTAssertEqual(viewModel.currentPage, 2)
        viewModel.isFetchingNextPage = false

        // test if loadMoreMoviesIfNeeded wont work again because it is exceeded the num of pages.
        viewModel.loadMoreMoviesIfNeeded(movie: viewModel.allMovies.last!)
        XCTAssertFalse(viewModel.isFetchingNextPage)
    }

    func testIsFetchingMoviesBool() {
        // simulate any response it doesn't matter respons in this case
        mockNetworkManager.responseData = "".data(using: .utf8)!

        XCTAssertFalse(viewModel.isFetchingMovies)
        viewModel.fetchMovies()
        XCTAssertTrue(viewModel.isFetchingMovies)
    }
}
