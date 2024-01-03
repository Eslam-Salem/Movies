//
//  ServerImageView.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import SwiftUI
import Kingfisher

struct ServerImageView: View {
    let imagePath: String
    
    var body: some View {
        KFImage.url(URL(string: "\(Constants.imageBaseURL)\(imagePath)"))
            .resizable()
            .scaledToFit()
            .onAppear {
                ImageLoaderConfigurator.shared.configureDownloader()
            }
            .clipped()
    }
}

#Preview {
    ServerImageView(imagePath: "/rNQompSTfAG5O2iXSH8Phay4L45.jpg")
}
