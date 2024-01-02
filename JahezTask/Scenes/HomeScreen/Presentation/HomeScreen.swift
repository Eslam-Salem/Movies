//
//  MovieListView.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import SwiftUI

struct HomeScreen: View {
    @State private var searchText: String = ""
    @State private var selectedGenres: Set<Int> = []

    @StateObject private var viewModel = HomeScreenViewModel()

    var body: some View {
        VStack {
            // Search bar
            MoviesSearchBarView(text: $searchText)
                .padding(.vertical, 8)
                .onChange(of: searchText) {
                    viewModel.filterMovies(selectedGenres: selectedGenres, searchText: searchText)
                }
            
            // Screen Title
            Text("Watch New Movies")
                .font(.title)
                .bold()
                .foregroundColor(Color.appYellow)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            
            // Filter
            FilterChipsView(selectedGenres: $selectedGenres, allGenres: viewModel.genres)
                .onChange(of: selectedGenres) {
                    viewModel.filterMovies(selectedGenres: selectedGenres, searchText: searchText)
                }
            // Movies List
            if viewModel.isFetchingMovies {
              ProgressView("Fetching Movies...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color.appYellow)
                    .tint(Color.appYellow)
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(
                        columns: [GridItem(.flexible()),GridItem(.flexible())],
                        spacing: 16
                    ) {
                        ForEach(viewModel.filterdMovies) { movie in
                            MovieItemView(movie: movie)
                                .onAppear {
                                    viewModel.loadMoreMoviesIfNeeded(movie: movie)
                                }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            
            // Pagination progress view
            if viewModel.isFetchingNextPage {
              ProgressView("Loading more ..")
                .frame(maxWidth: .infinity)
                .background(Color.appYellow)
            }
            
        }
        .onAppear {
            viewModel.fetchGenres()
            viewModel.fetchMovies()
        }
        .background(Color.black)
    }
}

#Preview {
    HomeScreen()
}
