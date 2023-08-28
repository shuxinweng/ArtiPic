//
//  SinglePhotoView.swift
//  ArtiPic
//
//  Created by Dream K on 8/27/23.
//

import SwiftUI
import Kingfisher
import FirebaseFirestore


struct SinglePhotoView: View {
    let photo: Photo
    
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
            
            // Add other photo details here
            
            Spacer()
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
