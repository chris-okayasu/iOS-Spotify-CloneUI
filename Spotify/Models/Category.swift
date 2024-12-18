//
//  Category.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

/// on a real project this probably should be an struct since we probably don't know how many categories we will have or add later
/// since this is more about UI I don't want to make this logic complex so far.

import Foundation

// text elements, and iterable means can use a for to loop them basically
enum Category: String, CaseIterable {
    case all, music, podcasts, audiobooks
}
