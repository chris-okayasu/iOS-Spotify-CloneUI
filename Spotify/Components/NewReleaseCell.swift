//
//  NewReleaseCell.swift
//  Spotify
//
//  Created by chris on 2024/12/19.
//

import SwiftUI

struct NewReleaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "New Release from"
    var subheadline: String? = "Some artist"
    var title: String? = "Some title"
    var subtitle: String? = "Some subtitle"
    
    // to aviod create code on the preview or while calling this view
    // I am making this function as nill by wrapping in parenthesis
    var onAddToPlaylistPressed: (() -> Void )? = nil
    var onPlayPressed: (() -> Void )? = nil
    var body: some View {
        
        VStack(spacing: 16){
            HStack(spacing: 8){
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading,spacing: 2){
                    if let headline {
                        Text(headline)
                            .foregroundStyle(.colorGray)
                            .font(.callout)
                    }
                    if let subheadline {
                        Text(subheadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.colorLightGray)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 150, height: 150)
                
                
                VStack(alignment: .leading, spacing: 32){ // to have al the section vertically
                    
                    VStack(alignment: .leading, spacing: 2){
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.colorLightGray)
                        }
                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(.colorGray)
                        }
                        
                    }
                    
                    .font(.callout)
                    HStack(spacing: 4) {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.colorLightGray)
                            .font(.title3)
                            .padding(4) // making the clickable section bigger to help the user to touch the button ...
                            .background(Color.black.opacity(0.0001)) // hidding the color of padding
                            .onTapGesture {
                                onAddToPlaylistPressed?()
                            }
                            .offset(x: -4) // sice I made the button bigger by adding a padding, I have to line the button with the rest of the desing reducing 4 'pixels'
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.colorLightGray)
                            .font(.title)
                    }
                }
                .padding(.bottom, 8)
                .padding(.top, 8)
                .padding(.trailing, 16)
            }
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }
        }
    }
}

#Preview {
    ZStack {
        Color.colorBg.ignoresSafeArea()
        NewReleaseCell()
            .padding()
    }
}
