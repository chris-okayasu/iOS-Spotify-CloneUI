//
//  HomeView.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.colorBg.ignoresSafeArea() // full color of the screen
            //MARK: Profile Pic and Horizontal Categories
            HStack{
                ImageLoaderView()
                    .frame(width: 30, height: 30) // small as user profile picture
                    .background(.colorBg) // just in case the image has any transparent stuff
                    .clipShape(Circle()) // transform image into circle
            }
        }
    }
}

#Preview {
    HomeView()
}
