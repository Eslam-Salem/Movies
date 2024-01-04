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
    @Published var errorMessage: String?
    var allMovies: [Movie] = []
    var currentPage = 1
    var totalNumberOfPages = 1

    private var cancellables: Set<AnyCancellable> = []
    private let interactor: HomeInteractor
    
    init(interactor: HomeInteractor = HomeInteractor(movieRepository: MovieDataRepository(networkManager: ServerNetworkManager()))) {
        self.interactor = interactor
    }
    
    func fetchGenres() {
        interactor.getMovieGenres()
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
    
    func loadMoreMoviesIfNeeded(movie: Movie, selectedGenres: Set<Int>, searchText: String) {
        /// check  to make the pagination logic happens only in normal scrolling not while scrolling with filtering
        let isLastMovieInTheList = movie == allMovies.last
        let isInFilterMode = !selectedGenres.isEmpty || !searchText.isEmpty
        guard isLastMovieInTheList, currentPage < totalNumberOfPages, !isInFilterMode else { return }
        currentPage += 1
        isFetchingNextPage = true
        requestMoviesList(requestContext: .pagination)
    }
    
    private func requestMoviesList(requestContext: RequestContext) {
        interactor.getPopularMovies(page: currentPage, requestContext: requestContext)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.stopFetchingDataIndicator()
                case .failure(let error):
                    self?.stopFetchingDataIndicator()
                    self?.handleNetworkError(error)
                }
            },receiveValue: { [weak self] moviesResponseModel in
                self?.allMovies.append(contentsOf: moviesResponseModel.results ?? [])
                self?.totalNumberOfPages = moviesResponseModel.totalPages ?? 1
                self?.filterMovies(selectedGenres: [], searchText: "")
            })
            .store(in: &cancellables)
    }
    
    private func handleNetworkError(_ error: NetworkError) {
        errorMessage = error.localizedDescription
    }
    
    private func stopFetchingDataIndicator() {
        isFetchingMovies = false
        isFetchingNextPage = false
    }
    
    func navigateToMovieDetails(movie: Movie, coordinator: Coordinator) {
        if NetworkReachability.isOnline {
            coordinator.push(.movieDetails(movieID: movie.id))
        } else {
            errorMessage = "No internet connection!!" 
        }
    }
}
