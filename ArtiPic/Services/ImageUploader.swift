//
//  ImageUploader.swift
//  ArtiPic
//
//  Created by Dream K on 8/14/23.
//

import UIKit
import Firebase
import FirebaseStorage

struct ImageUploader{
    static func uploadImage(image: UIImage) async throws -> String?{
        guard let imageData = image.jpegData(compressionQuality: 0.5) else{return nil}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        do{
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch{
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}

//struct ImageUploader{
//    static func uploadImage(image: UIImage, compressionQualityCGFloat: CGFloat, storageName: String) async throws -> String?{
//        guard let imageData = image.jpegData(compressionQuality: compressionQualityCGFloat) else{return nil}
//        print( "storeageName: \(storageName)")
//        let filename = NSUUID().uuidString
//        print("filename: " ,filename, "storeageName: \(storageName)")
//        let ref = Storage.storage().reference(withPath: "\(storageName)/\(filename)")
//
//        do{
//            let _ = try await ref.putDataAsync(imageData)
//            let url = try await ref.downloadURL()
//            return url.absoluteString
//        }catch{
//            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
//            return nil
//        }
//    }
//}
