//
//  HeaderUI.swift
//  Spotify
//
//  Created by chris on 2024/12/31.
//

import SwiftUI

struct HeaderUI: View {
    var body: some View {
        //MARK: Header
        ZStack{
            Text("roduct.title")
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(Color.colorDarkGray.opacity(0.7))
                .clipShape(Circle())
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

#Preview {
    HeaderUI()
}
