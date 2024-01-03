//
//  LoadingView.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import SwiftUI

struct LoadingView: View {
    var text: String?
    var maxHeight: CGFloat
    
    var body: some View {
        ProgressView(text ?? "")
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .foregroundColor(Color.appYellow)
            .tint(Color.appYellow)
    }
}

#Preview {
    LoadingView(maxHeight: 100)
}
