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

    var body: some View {
        StickyImage(
            image: imageName,
            title: "title",
            subtitle: "subtitle",
            textSize: 40,
            shadowColor: .colorBg
        )
    }
}

#Preview {
    ZStack {
        Color.colorBg.ignoresSafeArea()
        ScrollView {
            PlayListHeader()

            VStack {
                ForEach(0..<20) { _ in
                    Text("Content")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.colorDarkGray)
                        .padding(.horizontal)
                }
            }
        }
    }
}
