//
//  ExtensionView.swift
//  Spotify
//
//  Created by chris on 2024/12/19.
//

import Foundation
import SwiftUI

// New functionalities to the default swift views

extension View{
    func themeColors(isSelected: Bool) -> some View{
        self
            .background(isSelected ? .colorGreen : .colorDarkGray)
    }
}
