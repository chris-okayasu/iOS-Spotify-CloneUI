//
//  PlaylistDescriptionCell.swift
//  Spotify
//
//  Created by chris on 2024/12/20.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    
    var descriptionText: String = Product.mock.description
    var userName: String = "Chris"
    var subheadline: String = "Some headline here"
    var onAddToPlaylistPressed: (()->Void)? = nil
    var onDownloadPressed: (()->Void)? = nil
    var onSharePressed: (()->Void)? = nil
    var onEllipsisPressed: (()->Void)? = nil
    var onShufflePressed: (()->Void)? = nil
    var onPlayPressed: (()->Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16){
            Text(descriptionText)
                .foregroundStyle(.colorLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            madeForYouSection
            Text(subheadline)
            buttonsRow
            .font(.title3)
        }
//        .padding(8)
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.colorGray)
    }
    
    private var madeForYouSection: some View {
        HStack(spacing: 8){
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.colorGreen)
            Text("Made for ")
            +
            Text(userName)
                .bold()
                .foregroundStyle(.colorLightGray)
            
            // Separate made for and username to use the spacing of the hstack
        }
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0){
            HStack(spacing: 0){
                Image(systemName: "plus.circle")
                // make the button bigger and hide the borders or extra colors
                    .padding(8)
                    .background(Color.colorBg.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down.circle")
                // make the button bigger and hide the borders or extra colors
                    .padding(8)
                    .background(Color.colorBg.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "square.and.arrow.up")
                // make the button bigger and hide the borders or extra colors
                    .padding(8)
                    .background(Color.colorBg.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "ellipsis")
                // make the button bigger and hide the borders or extra colors
                    .padding(8)
                    .background(Color.colorBg.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 8){
                Image(systemName: "shuffle")
                // make the button bigger and hide the borders or extra colors
                    .font(.system(size: 24))
                    .background(Color.colorBg.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "play.circle.fill")
                // make the button bigger and hide the borders or extra colors
                    .font(.system(size: 46))
                    .background(Color.colorBg.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .foregroundStyle(.colorGreen)
        }
    }
}

#Preview {
    ZStack{
        Color.colorBg.ignoresSafeArea()
        PlaylistDescriptionCell()
    }
}
