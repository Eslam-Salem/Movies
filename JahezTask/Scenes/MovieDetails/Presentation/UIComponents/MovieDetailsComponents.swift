//
//  MovieDetailsComponents.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import SwiftUI

struct MovieDetailsComponents: View {
    var movieDetails: MovieDetailsResponseModel?
    var genereNames: String
    var languages: String
    var releaseDate: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Large Image
                ServerImageView(imagePath: movieDetails?.backdropPath ?? "")
                
                // Small Image with Labels
                HStack(alignment: .top, spacing: 4) {
                    ServerImageView(imagePath: movieDetails?.posterPath ?? "")
                        .frame(width: 100)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        let movieTitle = movieDetails?.originalTitle ?? ""
                        Text("\(movieTitle) (\(releaseDate))")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text(genereNames)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                
                // Movie OverView
                Text(movieDetails?.overview ?? "")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                
                Spacer()
                
                // Additional Labels
                VStack(alignment: .leading, spacing: 4) {
                    // Homepage
                    BoldRegularTextView(boldText: "Homepage: ", regularText: movieDetails?.homepage ?? "", isRegularTextLink: true)
                    
                    // Language
                    BoldRegularTextView(boldText: "Languages: ", regularText: languages)
                    
                    // status and runtime
                    HStack {
                        BoldRegularTextView(boldText: "Status: ", regularText: movieDetails?.status ?? "")
                        Spacer()
                        BoldRegularTextView(boldText: "Runtime: ", regularText: "\(movieDetails?.runtime ?? 0) Minutes")
                    }
                    
                    // budget and revenue
                    HStack {
                        BoldRegularTextView(boldText: "Budget: ", regularText: "\(movieDetails?.budget ?? 0)$")
                        Spacer()
                        BoldRegularTextView(boldText: "Revenue: ", regularText: "\(movieDetails?.revenue ?? 0)$")
                    }
                }

            }
        }
    }
}

#Preview {
    let customMovieDetails = MovieDetailsResponseModel(
        backdropPath: "/5iidzov8DrsSyZdefeo7jBLDNUW.jpg",
        budget: 50000000,
        genres: [MovieGenre(id: 1, name: "Action")],
        homepage: "http://www.customhomepage.com",
        id: 123456,
        originalTitle: "Custom Original Title",
        overview: "This is a custom overview for the movie.",
        posterPath: "/rNQompSTfAG5O2iXSH8Phay4L45.jpg",
        spokenLanguages: [SpokenLanguage(englishName: "Custom English")],
        status: "Custom Status",
        revenue: 100000000,
        runtime: 150,
        releaseDate: "2023-5-21"
    )
    
    return MovieDetailsComponents(
        movieDetails: customMovieDetails,
        genereNames: "Action, Drama",
        languages: "English, Arabic",
        releaseDate: "2023-5"
    )
    .background(Color.black)
}
