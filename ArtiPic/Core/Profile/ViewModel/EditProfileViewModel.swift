//
//  EditProfileViewModel.swift
//  ArtiPic
//
//  Created by Dream K on 8/14/23.
//

import PhotosUI
import Firebase
import SwiftUI
import FirebaseFirestore

@MainActor
class EditProfileViewModel: ObservableObject{
    @Published var user: User
    
    
    @Published var selectedImage: PhotosPickerItem?{
        didSet{Task{await loadImage(fromItem: selectedImage)}}
    }
    @Published var profileImage: Image?
    
    @Published var fullname = ""
    @Published var bio = ""
    
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname{
            self.fullname = fullname
        }
        
        if let bio = user.bio{
            self.bio = bio
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async{
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else{return}
        guard let uiImage = UIImage(data: data) else{return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws{
        
        var data = [String: Any]()
        
        // update profile image if changed
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage, compressionQualityCGFloat: 0.5, storageName: "profile_image")
            data["profileImageUrl"] = imageUrl
        }
        
        // update name if changed
        if !fullname.isEmpty && user.fullname != fullname{
            //print("DEBUG: Update fullname \(fullname)")
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != fullname{
            //print("DEBUG: Update bio \(bio)")
            data["bio"] = bio
        }
        
        if !data.isEmpty{
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
