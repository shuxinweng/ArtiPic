//
//  Photo.swift
//  ArtiPic
//
//  Created by Dream K on 8/24/23.
//

import Foundation
import Firebase

struct Photo: Identifiable, Hashable, Codable{
    let id: String
    let ownerUid: String
    let keyword: String
    let prompt: String
    let imageUrl: String
    let isCollected: Bool
    let timestamp: Timestamp
    var user: User?
}
