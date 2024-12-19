//
//  HomeView.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

import SwiftUI

struct HomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    var body: some View {
        ZStack{
            Color.red.ignoresSafeArea() // full color of the screen
//            Color.colorBg.ignoresSafeArea() // full color of the screen
            
            //MARK: Profile Pic and Horizontal Categories
            ScrollView(.vertical){
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        ForEach(0..<10) { _ in
                            Rectangle()
                                .frame(width: 200, height: 200)
                        }
                    } header: {
                        header
                    }

                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped() // This is awesome, with this line we can hide the content 'behind' the lazy component
        }
        .task {
            await fetchUser()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HStack(spacing: 0){ // removing the space between profile pic and categories
            
            //NOTE: this ZStack is tricky and I want to mention since I think is cool,
            //in order to avoid screen moving while profile picture is back from db
            //I am separating by ZStack and adding a frame at the bottom, on this way
            //even if I still don't have the image loaded the space is already there
            //so the categories will NOT be force to move few seconds while the image pop-up
            
            ZStack{
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image) // loading the image of the user
                       
                        .background(.colorBg) // just in case the image has any transparent stuff
                        .clipShape(Circle()) // transform image into circle
                        .onTapGesture {
    //                        TODO: go to profile screen
                        }
                }
            }
            .frame(width: 30, height: 30) // small as user profile picture
            
            ScrollView(.horizontal){
                HStack (spacing: 8){
                    // loop the enum and use the hidden id of the string as iterable to loop them
                    // CaseIterable == allCases
                    ForEach(Category.allCases, id: \.self){ c in
                        CategoryCell(title: c.rawValue.capitalized,
                                     isSelected: c == selectedCategory)
                        .onTapGesture {
                            selectedCategory = c // select the category by clicking
                        }
                    }
                }
                .padding(.horizontal, 16) // adding the space between profile pic and categories here (more natural)
            }
            .scrollIndicators(.hidden) // to hide the small bar indicator
        }
        .padding(.vertical, 24)
//        .background(Color.blue)
        .padding(.leading, 16) // Do not use horizontal since the components(categories) will cut before the screen ends
        .background(Color.blue)
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
