//
//  PlantView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/21/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct PlantView: View {
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
        
        db.collection("Plant").getDocuments { snapshot, error in
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

struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        PlantView()
    }
}
