//
//  CategoriesViewModel.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/15/23.
//

import Foundation
import FirebaseFirestore

class CategoriesViewModel: ObservableObject {
    @Published var categories: [Categories] = []
    private var db = Firestore.firestore()
    
    init() {
        
    }
    
}
