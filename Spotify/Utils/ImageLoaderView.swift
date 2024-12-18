//
//  ImageLoaderView.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

///using var due to I want skip init since this is more about design,
///if you want to use "let" instead of "var" you can do it but is necessary to create the init ->
///init() and declare the let (urlString, resizingMode) there, them when you use ImageLoaderView() is required to use the parameters.

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fit
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay{
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false) // user never touch the image, if they clic it is touching the rectangle behind
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
