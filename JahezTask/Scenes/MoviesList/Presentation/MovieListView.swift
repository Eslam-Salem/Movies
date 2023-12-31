//
//  MovieListView.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import SwiftUI

struct MovieListView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = MovieListViewModel(
        interactor: MovieInteractor(movieRepository: MovieDataRepository(networkManager: ServerNetworkManager()))
    )

    var body: some View {
        NavigationView {
            VStack {
                MoviewSearchBarView(text: $searchText)
                    .padding()
                
                Text("Watch New Movies")
                    .font(.headline)
                    .foregroundColor(Color.appYellow)
                
                FilterChipsView(allGenres: viewModel.genres)
                    .padding(.horizontal)
                
                List(viewModel.movies) { movie in
                    MovieListItemView(movie: movie)
                        .onAppear {
                            if viewModel.movies.isLastItem(movie) {
                                viewModel.loadMoreMovies()
                            }
                        }
                }
            }
            .background(Color.black)
        }
    }
}

extension RandomAccessCollection where Self: MutableCollection, Element: Identifiable {
    func isLastItem(_ item: Element) -> Bool {
        guard let index = firstIndex(where: { $0.id == item.id }) else {
            return false
        }
        return index == self.index(before: endIndex)
    }
}

#Preview {
    MovieListView()
}
