//
//  SongRowCell.swift
//  Spotify
//
//  Created by chris on 2024/12/31.
//

import SwiftUI

struct SongRowCell: View {
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "Some title too long here to see how it looks"
    var subtitle: String? = "Some subtitle too long here to see how it looks"
    
    var onCellPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack{
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.colorLightGray)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.colorGray)
                }
            }
            // make sure the size is always max horizontally
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            Image(systemName: "ellipsis")
                .padding(16)
                .font(.system(size: 16))
                .foregroundStyle(.colorLightGray)
                .background(Color.colorBg)
                .onTapGesture { onEllipsisPressed?() }
        }
            .foregroundStyle(.red)
    }
}

#Preview {
    ZStack{
        Color.colorBg.ignoresSafeArea()
        VStack{
            SongRowCell()
            SongRowCell()            
            SongRowCell()            
            SongRowCell()            
        }
    }
}
