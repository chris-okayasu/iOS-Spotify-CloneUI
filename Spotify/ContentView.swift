//
//  ContentView.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(users) { p in
                    Text(p.firstName)
                        .foregroundStyle(.colorDarkGray)
                }
            }
        }
        
        .padding()
        .task {
            await fetchData()
        }
    }
    
    private func fetchData() async {
        do {
            users = try await APIHelper().getUsers()
            products = try await APIHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
