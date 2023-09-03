//
//  PhotosView.swift
//  ArtiPic
//
//  Created by Dream K on 8/27/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

struct PhotosView: View {
    let keyword: String
    @State private var photos: [Photo] = []

    var body: some View {
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
        .onAppear {
            fetchPhotos()
        }
    }
    
    private func fetchPhotos() {
        let db = Firestore.firestore()
        db.collection("categories").document(keyword).collection(keyword).getDocuments { snapshot, error in
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

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView(keyword: "animal")
    }
}
