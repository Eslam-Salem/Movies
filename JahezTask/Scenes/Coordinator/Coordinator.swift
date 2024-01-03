//
//  Coordinator.swift
//  JahezTask
//
//  Created by Eslam Salem on 1/01/2024.
//

import SwiftUI

enum Page: Hashable {
    case homeScreen
    case movieDetails(movieID: Int)
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()

    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .homeScreen:
            HomeScreen()
        case .movieDetails(let id):
            MovieDetailsScreen(movieID: id)
        }
    }
}
