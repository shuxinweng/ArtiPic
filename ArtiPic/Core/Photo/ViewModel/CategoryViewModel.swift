//
//  CategoryViewModel.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/16/23.
//

import Foundation
import FirebaseFirestore

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    private var db = Firestore.firestore()
    
    init () {
        
    }
}
