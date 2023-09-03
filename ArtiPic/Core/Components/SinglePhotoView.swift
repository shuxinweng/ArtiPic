//
//  SinglePhotoView.swift
//  ArtiPic
//
//  Created by Dream K on 8/27/23.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseFirestore

struct SinglePhotoView: View {
    let photo: Photo
    @State private var isSaved: Bool = false
    @State private var photoDocumentSnapshot: DocumentSnapshot?
    
    var body: some View {
        VStack {
            KFImage(URL(string: photo.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .shadow(radius: 5)
                .padding(4)
            
            Text(photo.prompt)
                .font(.headline)
                .padding()
            
            Button(action: {
                Task{
                    try await toggleSave()
                    await fetchPhotoDocumentSnapshot()
                }
            }) {
                Image(systemName: isSaved ? "bookmark.fill" : (photoDocumentSnapshot?.exists ?? false ? "bookmark.fill" : "bookmark"))
                   .font(.system(size: 24))
                   .foregroundColor(isSaved ? .brown : .gray)
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                await fetchPhotoDocumentSnapshot()
            }
        }
    }
    
    private func fetchPhotoDocumentSnapshot() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let userPhotosCollectionRef = db.collection("users").document(uid).collection("collectedPhotos")
        let document = userPhotosCollectionRef.document(photo.id)
        do {
            photoDocumentSnapshot = try await document.getDocument()
        } catch {
            print("Error fetching photo document snapshot: \(error.localizedDescription)")
        }
    }
    
    
    private func toggleSave() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let userPhotosCollectionRef = db.collection("users").document(uid).collection("collectedPhotos")
        
        let photoDocument = userPhotosCollectionRef.document(photo.id)
        let photoDocumentSnapshot = try await photoDocument.getDocument()
        
        if photoDocumentSnapshot.exists {
            // Photo is already in the collection, so remove it
            try await photoDocument.delete()
            DispatchQueue.main.async {
                isSaved = false
            }
        } else {
            // Photo is not in the collection, so add it
            let photoData: [String: Any] = [
                "id": photo.id,
                "ownerUid": photo.ownerUid,
                "keyword": photo.keyword,
                "prompt": photo.prompt,
                "imageUrl": photo.imageUrl,
                "isCollected": photo.isCollected,
                "timestamp": photo.timestamp
            ]
            
            try await photoDocument.setData(photoData)
            DispatchQueue.main.async {
                isSaved = true
            }
        }
    }

}

struct SinglePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePhoto = Photo(
            id: "sampleId",
            ownerUid: "sampleOwnerUid",
            keyword: "sampleKeyword",
            prompt: "Sample Prompt",
            imageUrl: "sampleImageUrl",
            isCollected: false,
            timestamp: Timestamp()
        )
        SinglePhotoView(photo: samplePhoto)
    }
}
