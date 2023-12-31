//
//  MoviesListViewModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine

class MovieListViewModel: ObservableObject {
    @Published var genres: [MovieGenre] = []
    @Published var movies: [Movie] = []
    private var cancellables: Set<AnyCancellable> = []
    private let interactor: MovieInteractor
    private var currentPage = 1
    
    init(interactor: MovieInteractor) {
        self.interactor = interactor
        fetchGenres()
        fetchMovies()
    }
    
    func fetchGenres() {
        interactor.getMovieGenres()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                      self?.genres = response.genres
                  })
            .store(in: &cancellables)
    }
    
    func fetchMovies() {
        interactor.getPopularMovies(page: currentPage)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] newMovies in
                    self?.movies.append(contentsOf: newMovies.results)
                  })
            .store(in: &cancellables)
    }
    
    func loadMoreMovies() {
        currentPage += 1
        fetchMovies()
    }
}
