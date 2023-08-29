//
//  CollectionView.swift
//  ArtiPic
//
//  Created by Dream K on 8/13/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

struct CollectionView: View {
    let user: User
    @State private var photos: [Photo] = []

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(photos) { photo in
                        NavigationLink(destination: SinglePhotoView(photo: photo)) {
                            KFImage(URL(string: photo.imageUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                        }
                    }
                }
            }
            .navigationBarTitle("Collection")
            .onAppear {
                fetchPhotos()
            }
        }
    }
    private func fetchPhotos() {
        let uid = user.id
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).collection("collectedPhotos").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching photos: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                return
            }
            
            self.photos = documents.compactMap { document in
                do {
                    let photo = try document.data(as: Photo.self)
                    return photo
                } catch {
                    print("Error decoding photo: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }

}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(user: User.MOCK_USERS[0])
    }
}
