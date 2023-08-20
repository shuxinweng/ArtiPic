//
//  AIView.swift
//  ArtiPic
//
//  Created by Dream K on 8/13/23.
//

import SwiftUI
import OpenAIKit
import FirebaseFirestore
import FirebaseStorage

struct AIView: View {
    @ObservedObject var AIModel = AIViewModel()
    @State var text = ""
    @State var image: UIImage?
    @State var retrievedImages = [UIImage]()
    @State var isImageGenerated = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                }
                else {
                    Text("Enter Image Prompt")
                }
                if isImageGenerated {
                    Button {
                        uploadPhoto()
                    } label: {
                        Text("Upload photo")
                    }
                }
                
                Spacer()
                
                TextField("Image Prompt", text: $text)
                    .padding()
                
                Button("Generate") {
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        Task {
                            let result = await AIModel.generateImage(prompt: text)
                            if result == nil {
                                print("Failed to get image")
                            }
                            self.image = result
                            self.isImageGenerated = true
                        }
                    }
                }
            }
            .navigationTitle("ArtiPic")
            .onAppear {
                AIModel.setup()
            }
            .padding()
        }
    }
    
    func uploadPhoto() {
        guard image != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        
        let imageData = image!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let path = "photos/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
            metadata, error in
            
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                db.collection("photos").addDocument(data: [
                    "prompt": self.text,    // Include the prompt field
                    "imageUrl": path
                ]) { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.retrievedImages.append(self.image!)
                        }
                    }
                }
            }
        }
    }
}

struct AIView_Previews: PreviewProvider {
    static var previews: some View {
        AIView()
    }
}
