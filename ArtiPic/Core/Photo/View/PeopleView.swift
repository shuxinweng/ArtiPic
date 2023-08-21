//
//  PeopleView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/21/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct PeopleView: View {
    @State var retrievedImages = [PhotoInfo]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(retrievedImages, id: \.self.image) { photoInfo in
                        NavigationLink(destination: SinglePhotoView(photoInfo: photoInfo)) {
                            Image(uiImage: photoInfo.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                        }
                    }
                }
            }
            .navigationTitle("Photo Gallery")
        }
        .onAppear {
            retrievePhotos()
        }
    }
    
    func retrievePhotos() {
        self.retrievedImages.removeAll()
        
        let db = Firestore.firestore()
        
        db.collection("People").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                for doc in snapshot!.documents {
                    if let imageUrl = doc["imageUrl"] as? String,
                       let keyword = doc["keyword"] as? String,
                       let prompt = doc["prompt"] as? String {
                        
                        let storageRef = Storage.storage().reference()
                        let fileRef = storageRef.child(imageUrl)
                        
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil && data != nil {
                                if let image = UIImage(data: data!) {
                                    let photoInfo = PhotoInfo(image: image, keyword: keyword, prompt: prompt)
                                    
                                    print("Image fetched:", imageUrl)
                                    
                                    DispatchQueue.main.async {
                                        retrievedImages.append(photoInfo)
                                    }
                                }
                            } else {
                                print("Error fetching image:", error?.localizedDescription ?? "Unknown error")
                            }
                        }
                    }
                }
            } else {
                print("Error fetching documents:", error?.localizedDescription ?? "Unknown error")
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
