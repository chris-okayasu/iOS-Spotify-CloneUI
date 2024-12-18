//
//  HomeView.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

import SwiftUI

struct HomeView: View {
    
    @State private var currentUser: User? = nil
    
    var body: some View {
        ZStack{
            Color.colorBg.ignoresSafeArea() // full color of the screen
            
            //MARK: Profile Pic and Horizontal Categories
            HStack{
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image) // loading the image of the user
                        .frame(width: 30, height: 30) // small as user profile picture
                        .background(.colorBg) // just in case the image has any transparent stuff
                        .clipShape(Circle()) // transform image into circle
                        .onTapGesture {
    //                        TODO: go to profile screen
                        }
                }
                ScrollView(.horizontal){
                    HStack (spacing: 8){
                        ForEach(0..<100){ _ in
                            Rectangle()
                                .fill(.colorGreen)
                                .frame(width: 10, height: 10)
                        }
                    }
                }
                .scrollIndicators(.hidden) // to hide the small bar indicator
            }
            .task {
                await fetchUser()
            }
        }
    }
    private func fetchUser() async {
        do {
            currentUser = try await APIHelper().getUsers().last // it must be only one user.
        } catch {
            
        }
    }
}

#Preview {
    HomeView()
}
