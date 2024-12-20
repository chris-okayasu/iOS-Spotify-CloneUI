//
//  User.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Double
    let weight: Double
    
    static var mock: User {
        User(
            id: 142,
            firstName: "Chris",
            lastName: "F",
            age: 25,
            email: "chris@mail.com",
            phone: "1234567890",
            username: "chris",
            password: "password",
            image: "https://picsum.photos/500/500",
            height: 180,
            weight: 70
        )
             }
    
    var work: String {
        "Worker as Some Job"
    }
    var education: String {
        "Graduate Degree"
    }
    var aboutMe: String {
        "This is a sentence about me that will look good on my profile!"
    }
   
    var images: [String] {
        ["https://picsum.photos/500/500", "https://picsum.photos/600/600", "https://picsum.photos/700/700"]
    }
    
}
