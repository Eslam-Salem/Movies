//
//  BoldRegularTextView.swift
//  JahezTask
//
//  Created by Eslam Salem on 02/01/2024.
//

import SwiftUI

struct BoldRegularTextView: View {
    var boldText: String
    var regularText: String
    var isRegularTextLink: Bool? = false

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(boldText)
                .foregroundColor(.white)
                .font(.caption)
                .fontWeight(.bold)
            
            if isRegularTextLink == true {
                if let textURL = URL(string: regularText) {
                    Link(destination: textURL, label: {
                        Text(textURL.description)
                            .foregroundColor(.blue)
                            .underline()
                            .font(.caption)
                    })
                } else {
                    Text(regularText)
                        .foregroundColor(.blue)
                        .underline()
                        .font(.caption)
                }
            } else {
                Text(regularText)
                    .foregroundColor(.white)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    BoldRegularTextView(boldText: "Revenue:", regularText: "2440000$")
        .background(Color.black)
}
