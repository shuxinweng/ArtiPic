//
//  PhotoViewModel.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/16/23.
//

import Foundation
import FirebaseFirestore

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private var db = Firestore.firestore()
    
    init () {
        
    }
}
