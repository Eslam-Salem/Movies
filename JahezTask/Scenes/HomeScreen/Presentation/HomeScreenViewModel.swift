//
//  HomeScreenViewModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine

class HomeScreenViewModel: ObservableObject {
    @Published var genres: [MovieGenre] = []
    @Published var filterdMovies: [Movie] = []
    @Published var isFetchingMovies = false
    @Published var isFetchingNextPage = false
    var allMovies: [Movie] = []
    var currentPage = 1
    var totalNumberOfPages = 1
    
    private var cancellables: Set<AnyCancellable> = []
    private let movieInteractor: MovieInteractor
    
    init(movieInteractor: MovieInteractor = MovieInteractor(movieRepository: MovieDataRepository(networkManager: ServerNetworkManager()))) {
        self.movieInteractor = movieInteractor
    }
    
    func fetchGenres() {
        movieInteractor.getMovieGenres()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                self?.genres = response.genres
            })
            .store(in: &cancellables)
    }
    
    func filterMovies(selectedGenres: Set<Int>, searchText: String) {
        var filteredMovies = allMovies
        // Filter by selected genres
        if !selectedGenres.isEmpty {
            filteredMovies = filteredMovies.filter { movie in
                return selectedGenres.allSatisfy { movie.genreIds?.contains($0) == true }
            }
        }
        // Filter by search text
        if !searchText.isEmpty {
            filteredMovies = filteredMovies.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) == true
            }
        }
        filterdMovies = filteredMovies
    }
    
    func fetchMovies() {
        isFetchingMovies = true
        requestMoviesList(requestContext: .initalCall)
    }
    
    func loadMoreMoviesIfNeeded(movie: Movie) {
        /// check on "movies" not "filtered movies" to make the pagination logic happens only in normal scrolling not while scrolling with filtering
        let isLastMovieInTheList = movie == allMovies.last
        guard isLastMovieInTheList, currentPage < totalNumberOfPages else { return }
        currentPage += 1
        isFetchingNextPage = true
        requestMoviesList(requestContext: .pagination)
    }
    
    private func requestMoviesList(requestContext: RequestContext) {
        movieInteractor.getPopularMovies(page: currentPage, requestContext: requestContext)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] moviesResponseModel in
                self?.allMovies.append(contentsOf: moviesResponseModel.results ?? [])
                self?.totalNumberOfPages = moviesResponseModel.totalPages ?? 1
                self?.isFetchingMovies = false
                self?.isFetchingNextPage = false
                self?.filterMovies(selectedGenres: [], searchText: "")
            })
            .store(in: &cancellables)
    }
}
