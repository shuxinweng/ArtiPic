//
//  PhotoView.swift
//  ArtiPic
//
//  Created by Dream K on 8/13/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct PhotoView: View {
    @State var retrievedImages = [UIImage]()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(retrievedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    }
                }
            }
        }
        .onAppear {
            retrievePhotos()
        }
    }
    
    func retrievePhotos() {
        self.retrievedImages.removeAll()
        
        let db = Firestore.firestore()
        
        db.collection("photos").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                
                for doc in snapshot!.documents {
                    paths.append(doc["imageUrl"] as! String)
                }
                
                for path in paths {
                    let storageRef = Storage.storage().reference()
                    
                    let fileRef = storageRef.child(path)
                    
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if error == nil && data != nil {
                            
                            if let image = UIImage(data: data!) {
                                
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
