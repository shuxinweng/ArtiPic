//
//  CategoryView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/21/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher

struct CategoryView: View {
    @State private var keywords: [String] = []
    @State private var categoryImages: [String: String] = [:]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(keywords, id: \.self) { keyword in
                    NavigationLink(destination: PhotosView(keyword: keyword)) {
                        CategoryRow(keyword: keyword, categoryImageURL: categoryImages[keyword] ?? "")
                                .background(Color.clear)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                    }
                }
            }
            .navigationBarTitle("Categories")
            .onAppear {
                fetchKeywords()
            }
        }
    }
    
        
    
    private func fetchKeywords() {
        let db = Firestore.firestore()
        db.collection("categories").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching keywords: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                return
            }
            
            self.keywords = documents.map { $0.documentID }
            
            // Fetch the first image URL for each keyword
            for keyword in self.keywords {
                db.collection("categories").document(keyword).collection(keyword).limit(to: 1).getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching category image: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let document = snapshot?.documents.first, let imageUrl = document["imageUrl"] as? String else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.categoryImages[keyword] = imageUrl
                    }
                }
            }
        }
    }
        
}

struct CategoryRow: View {
    var keyword: String
    var categoryImageURL: String
    
    init(keyword: String, categoryImageURL: String) {
        self.keyword = keyword
        self.categoryImageURL = categoryImageURL
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            KFImage(URL(string: categoryImageURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: 120)
                .cornerRadius(8)
                .shadow(radius: 5)
                .brightness(-0.4)
            
            
            HStack {
                Text(keyword.uppercased())
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .padding()
                    .fontWeight(.bold)
                    .shadow(radius: 100)
                    .cornerRadius(8)
                    .padding(15)
                
                
                Spacer ()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color.black)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

