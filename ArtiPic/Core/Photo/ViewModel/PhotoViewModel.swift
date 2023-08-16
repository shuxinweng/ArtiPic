//
//  PhotoViewModel.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/15/23.
//

import Foundation
import FirebaseFirestore

class PhotoViewModel: ObservableObject {
    @Published var photos: [PhotoModel] = []
    private var db = Firestore.firestore()
    
    init() {
        
    }
}
