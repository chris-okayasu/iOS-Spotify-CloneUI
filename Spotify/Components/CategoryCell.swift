//
//  CategoryCell.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

import SwiftUI

struct CategoryCell: View {
    var title: String = "All"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35) // basically for 'All' since normal size looks horrible
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(isSelected ? .colorGreen : .colorDarkGray)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack{
        Color.colorBg.ignoresSafeArea()
        VStack(spacing: 40){
            CategoryCell(title: "here is the title")
            CategoryCell(title: "here is the title", isSelected: true)
            CategoryCell(isSelected: true)
        }
    }
}
