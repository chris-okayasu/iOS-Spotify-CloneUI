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
    
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack{
            StickyImage(
                image: product.thumbnail,
                title: product.title,
                subtitle: product.brand,
                textSize: 40,
                shadowColor: .colorBg
            )
        }
        ScrollView(.vertical){
            LazyVStack(spacing: 12){
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
                ForEach(products) { product in
                    SongRowCell(
                        imageSize: 50,
                        imageName: product.firstImage,
                        title: product.title,
                        subtitle: product.brand,
                        onCellPressed: {
                            
                        },
                        onEllipsisPressed: {
                        }
                    )
                    .padding(.leading, 16)
                }
            }
        }
        .task {
            await fetchData()
        }
        .toolbar(.hidden, for: .navigationBar)
        
    }
    private func fetchData() async {
        do {
            products = try await APIHelper().getProducts()
        } catch {
            // Log any errors that occur during the data fetch process
            print("Error fetching data: \(error)")
        }
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
