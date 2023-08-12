//
//  User.swift
//  ArtiPic
//
//  Created by Dream K on 8/12/23.
//

import Foundation

struct User: Identifiable, Hashable, Codable{
    let id: String
    let email: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    var savedImage: [String]
}

extension User {
    static var MOCK_USERS: [User] = [
        User(id: NSUUID().uuidString, email: "user1@example.com", username: "user1", profileImageUrl: "touxiang", fullname: "User One", bio: "Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User OneBio for User One Bio for User One", savedImage: ["url1", "url2"]),
        User(id: NSUUID().uuidString, email: "user2@example.com", username: "user2", profileImageUrl: nil, fullname: "User Two", bio: "Bio for User Two", savedImage: ["url3", "url4"])
    ]
}
