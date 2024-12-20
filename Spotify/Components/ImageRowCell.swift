//
//  ImageRowCell.swift
//  Spotify
//
//  Created by chris on 2024/12/19.
//

import SwiftUI

struct ImageRowCell: View {
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var imageTitle: String? = "N/A"
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            if let imageTitle {
                Text(imageTitle)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.callout)
                    .foregroundStyle(Color.colorLightGray)
                    .padding(4)
                    .padding(.bottom, 20)
            }
        }
        .frame(width: imageSize)
        
    }
}

#Preview {
    ZStack{
        Color.colorBg.ignoresSafeArea()
        ImageRowCell()
    }
}
