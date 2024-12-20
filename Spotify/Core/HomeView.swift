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
    @State private var products: [Product] = []
    
    @State private var isRefreshing = false //pull-to-refresh
    
    var body: some View {
        ZStack{
            Color.colorBg.ignoresSafeArea() // full color of the screen
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        //MARK: Recents Section
                        recentsSection
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        //MARK: New Releases Section
                        if let product = products.first {
                            newReleaseSection(product: product)
                        }
                        
                        //MARK:
                        VStack(spacing: 8){
                            Text("Categories")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.colorLightGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(0..<10) { _ in
                                        ImageRowCell()
                                        
                                    }
                                    
                                }
                            }
                            .scrollIndicators(.hidden)
                        }
                        
                    } header: {
                        //MARK: Header
                        headerSection // categories marked as header and pinned
                    }
                }
                .padding(.top, 8)
            }
            .refreshable {
                await refreshData()
            }
            .scrollIndicators(.hidden)
            .clipped() // This is awesome, with this line we can hide the content 'behind' the lazy component
        }
        .task {
            await fetchData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var headerSection: some View {
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
        .background(Color.colorBg)
    }
    
    private var recentsSection: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 10), // First column
                GridItem(.flexible(), spacing: 10)  // Second column
            ],
            spacing: 8 // between columns
        ) {
            ForEach(products, id: \.id) { p in
                RecentsCell(imageName: p.firstImage, title: p.title)
                    .frame(maxWidth: .infinity, minHeight: 20) // 50% min height
                    .cornerRadius(8)
            }
        }
    }
    
    private func newReleaseSection(product: Product) -> some View {
        NewReleaseCell (
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: nil,
            onPlayPressed: nil
            // for real apps we can...->
//                                onAddToPlaylistPressed: {
//                                        nil
//                                },
//                                onPlayPressed: {
//
//                                }
        )
    }
    // let's do this function more fun making all the data randomly by shuffle
    // in case static data is needed just uncomment the last 2 lines.
    private func fetchData() async {
        do {
            
            let allProducts = try await APIHelper().getProducts()
            let randomProducts = allProducts.shuffled().prefix(8)
            products = Array(randomProducts)
            
            let allUsers = try await APIHelper().getUsers()
            if let randomUser = allUsers.shuffled().first {
                currentUser = randomUser
            }
            
//            currentUser = try await APIHelper().getUsers().last // it must be only one user.
//            products = try await Array(APIHelper().getProducts().prefix(8))
        } catch {
            
        }
    }
    
    // pull-to-refresh
    func refreshData() async {
        await fetchData()
    }
}

#Preview {
    HomeView()
}
