//
//  User.swift
//  ArtiPic
//
//  Created by Dream K on 8/12/23.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable{
    let id: String
    let email: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    var savedImage: [String]?
    var isVIP: Bool?
    
    var isCurrentUser: Bool{
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        User(id: NSUUID().uuidString, email: "user1@example.com", username: "user1", profileImageUrl: "touxiang", fullname: "User One", bio: "Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User One Bio for User OneBio for User One Bio for User One", savedImage: ["url1", "url2"], isVIP: false),
        User(id: NSUUID().uuidString, email: "user2@example.com", username: "user2", profileImageUrl: nil, fullname: "User Two", bio: "Bio for User Two", savedImage: ["url3", "url4"], isVIP: true)
    ]
}
