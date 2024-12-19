//
//  RecentsCell.swift
//  Spotify
//
//  Created by chris on 2024/12/19.
//

import SwiftUI

struct RecentsCell: View {
    var imageName: String = Constants.randomImage
    var title: String = "Some random title here and see how it looks"
    
    var body: some View {
        HStack{
            ImageLoaderView(urlString: imageName)
                .frame(width: 60, height: 60) // static size of the image
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2) // 1 line of text
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading) // horizontally as much as you can and force the text to the left again since sometimes is not multipleline and it will not be affected by the previous line of code
        }
        .padding(.trailing, 8)
        .background(Color.colorDarkGray)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

// Creating a fake scenario of grid
#Preview {
    ZStack {
        Color.colorBg.ignoresSafeArea()
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            spacing: 10
        ) {
            ForEach(0..<6, id: \.self) { _ in
                RecentsCell()
            }
        }
        .padding()
    }
}

