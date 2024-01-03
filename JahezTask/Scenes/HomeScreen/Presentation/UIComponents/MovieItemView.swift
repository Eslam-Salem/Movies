//
//  MovieItemView.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import SwiftUI

struct MovieItemView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .center) {
            
            ServerImageView(imagePath: movie.posterPath ?? "")
                
            Text(movie.title ?? "")
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .allowsTightening(true)
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .padding(.horizontal, 8)

            Text(movie.releaseDate ?? "")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.appDarkGray)
    }
}

#Preview {
    MovieItemView(movie: Movie(id: 0, title: "Rebel Moon - Part One: A Child of Fire", posterPath: "/ui4DrH1cKk2vkHshcUcGt2lKxCm.jpg", releaseDate: "2023-12-15", genreIds: [0]))
}
