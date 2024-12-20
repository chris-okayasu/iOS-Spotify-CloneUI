//
//  PlayListView.swift
//  Spotify
//
//  Created by chris on 2024/12/20.
//

import SwiftUI
import SwiftfulUI
struct PlayListHeader: View {
    var title: String = "PlayListHeader"
    var subtitle: String = "Subtitle"
    var imageName: String = Constants.randomImage
    var product: Product = .mock
    var user: User = .mock
    var body: some View {
        
        StickyImage(
            image: product.thumbnail,
            title: product.title,
            subtitle: product.brand,
            textSize: 40,
            shadowColor: .colorBg
        )
        
//        ScrollView(.vertical){
//            LazyVStack(spacing: 12){
        PlaylistDescriptionCell(
            descriptionText: product.description,
            userName: user.firstName,
            subheadline: product._brand,
            onAddToPlaylistPressed: nil,
            onDownloadPressed: nil,
            onSharePressed: nil,
            onEllipsisPressed: nil,
            onShufflePressed: nil,
            onPlayPressed: nil
        )
        .padding(.horizontal, 16)
//            }
//        }
    }
}

#Preview {
    ZStack {
        Color.colorBg.ignoresSafeArea()
        ScrollView {
            PlayListHeader()
        }
    }
}
