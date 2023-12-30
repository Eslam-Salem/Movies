//
//  MoviesListViewModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import Combine

class MovieListViewModel: ObservableObject {
    @Published var genres: [MovieGenre] = []
    private var cancellables: Set<AnyCancellable> = []
    private let interactor: MovieInteractor
    
    init(interactor: MovieInteractor) {
        self.interactor = interactor
        fetchGenres()
    }
    
    func fetchGenres() {
        interactor.getMovieGenres()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                      self?.genres = response.genres
                  })
            .store(in: &cancellables)
    }
}
