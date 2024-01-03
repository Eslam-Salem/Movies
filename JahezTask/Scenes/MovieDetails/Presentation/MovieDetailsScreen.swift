//
//  MovieDetailsScreen.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import SwiftUI

struct MovieDetailsScreen: View {
    @StateObject private var viewModel = MovieDetailsViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    let movieID: Int
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.isFetchingData {
                LoadingView(maxHeight: .infinity)
            } else {
                MovieDetailsComponents(
                    movieDetails: viewModel.movieDetails,
                    genereNames: viewModel.genereNames,
                    languages: viewModel.movieLanguages,
                    releaseDate: viewModel.formatReleaseData()
                )
            }
        }
        .onAppear {
            viewModel.fetchMovieDetails(id: movieID)
        }
        .background(Color.black)
    }
}

struct MovieDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsScreen(movieID: 572802)
    }
}
