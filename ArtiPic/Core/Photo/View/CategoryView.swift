//
//  CategoryView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/21/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CategoryView: View {
    @State private var keywords: [String] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(keywords, id: \.self) { keyword in
                    NavigationLink(destination: PhotosView(keyword: keyword)) {
                        CategoryRow(keyword: keyword)
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
        }
    }
}

struct CategoryRow: View {
    var keyword: String
    var backgroundColor: Color

    init(keyword: String) {
        self.keyword = keyword
        self.backgroundColor = Color.random()
    }

    var body: some View {
        HStack(alignment: .center) {
//            Image(keyword)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(height: 100)
//                .clipped()
//                .opacity(0.8)
            
            Text(keyword)
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .fontWeight(.bold)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(
            backgroundColor
                .cornerRadius(8)
        )
    }
}

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0..<1)
        let green = Double.random(in: 0..<1)
        let blue = Double.random(in: 0..<1)
        return Color(red: red, green: green, blue: blue)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
