//
//  Photo.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/15/23.
//

import Foundation

struct PhotoModel: Identifiable {
    let id: String
    let imageUrl: String
    let size: String
    let description: String
    let keyword: String
}
