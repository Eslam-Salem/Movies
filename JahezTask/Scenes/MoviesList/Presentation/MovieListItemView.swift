//
//  MovieListItemView.swift
//  JahezTask
//
//  Created by Eslam Salem on 30/12/2023.
//

import SwiftUI

struct MovieListItemView: View {
    @ObservedObject private var imageLoader = ImageLoader()
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(uiImage: imageLoader.image ?? UIImage(systemName: "photo")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    imageLoader.downloadImage(path: movie.posterPath)
                }
            
            Text(movie.title)
                .font(.headline)
                .foregroundColor(.white)

            Text("\(movie.releaseDate)")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.appDarkGray)
    }
}

#Preview {
    MovieListItemView(movie: Movie(id: 0, title: "Rebel Moon - Part One: A Child of Fire", posterPath: "/ui4DrH1cKk2vkHshcUcGt2lKxCm.jpg", releaseDate: "2023-12-15"))
}
