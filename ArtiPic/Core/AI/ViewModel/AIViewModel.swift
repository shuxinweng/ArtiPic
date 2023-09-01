//
//  AIViewModel.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/20/23.
//

import Foundation
import OpenAIKit
import SwiftUI
import FirebaseFirestore
import PhotosUI
import Firebase

class AIViewModel: ObservableObject {
    private var openai: OpenAI?
    private var uiImage: UIImage?
    @Published var postImage: Image?
    
    func setup() {
        if let path = Bundle.main.path(forResource: "OPENAI_API_KEY", ofType: "plist"),
           let configDict = NSDictionary(contentsOfFile: path),
           let apiKey = configDict["OPENAI_API_KEY"] as? String {
            openai = OpenAI(Configuration(
                organizationId: "Personal",
                apiKey: apiKey
            ))
        }
    }
        
    func generateImage(prompt: String) async -> UIImage? {
        guard let openai = openai else {
            return nil
        }
        
        do {
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)

            self.uiImage = image
            
            return image
        }
        catch {
            print(String(describing: error))
            return nil
        }
    }
        
    func uploadPhoto(keyword: String, prompt: String) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        let db = Firestore.firestore()
        var photoRef: DocumentReference!
        
//        // Check if the collection with the keyword exists
//        let photosCollectionRef = db.collection("photos").document("photos").collection(keyword)
//        let keywordCollectionSnapshot = try await photosCollectionRef.getDocuments()
//
//        if keywordCollectionSnapshot.isEmpty {
//            // If the collection doesn't exist, create it
//            photoRef = try await photosCollectionRef.addDocument(data: [:])
//        }
//        else{
//            photoRef = photosCollectionRef.document()
//        }
        
        // Check if the collection with the keyword exists
        let photosDocumentRef = db.collection("categories").document(keyword)
        let photosCollectionRef = db.collection("categories").document(keyword).collection(keyword)
        let keywordCollectionSnapshot = try await photosCollectionRef.getDocuments()
        
        if keywordCollectionSnapshot.isEmpty {
            // If the document and collection doesn't exist, create it
            try await photosDocumentRef.setData([:])
            photoRef = try await photosCollectionRef.addDocument(data: [:])
        }
        else{
            photoRef = photosCollectionRef.document()
        }
        
        let imageUrl = try await ImageUploader.uploadImage(image: uiImage, compressionQualityCGFloat: 0.8, storageName: "photos")
        
        if let imageUrl = imageUrl {
            let photo = Photo(id: photoRef.documentID, ownerUid: uid, keyword: keyword, prompt: prompt, imageUrl: imageUrl, isCollected: false, timestamp: Timestamp())
            let encodedPhoto = try Firestore.Encoder().encode(photo)
            try await photoRef.setData(encodedPhoto)
        } else {
            print("Image upload failed")
        }
    }
}
