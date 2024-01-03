//
//  MovieDetailsViewModel.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import Combine
import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetailsResponseModel?
    @Published var isFetchingData = false
    
    private var cancellables: Set<AnyCancellable> = []
    private let interactor: MovieDetailsInteractor
    
    var genereNames: String {
        return movieDetails?.genres?.compactMap { $0.name }.joined(separator: ", ") ?? ""
    }

    var movieLanguages: String {
        return movieDetails?.spokenLanguages?.compactMap { $0.englishName }.joined(separator: ", ") ?? ""
    }
    
    init(
        interactor: MovieDetailsInteractor = MovieDetailsInteractor(movieDetailsRepository: MovieDetailsDataRepository(networkManager: ServerNetworkManager()))
    ) {
        self.interactor = interactor
    }
    
    func fetchMovieDetails(id: Int) {
        isFetchingData = true
        interactor.getMovieDetails(id: "\(id)")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                self?.movieDetails = response
                self?.isFetchingData = false
            })
            .store(in: &cancellables)
    }
    
    func formatReleaseData() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let releaseDate = dateFormatter.date(from: movieDetails?.releaseDate ?? "") {
            let yearMonthFormatter = DateFormatter()
            yearMonthFormatter.dateFormat = "yyyy-MM"
            
            let yearMonthString = yearMonthFormatter.string(from: releaseDate)
            return yearMonthString
        } else {
            return movieDetails?.releaseDate ?? ""
        }
    }
}
