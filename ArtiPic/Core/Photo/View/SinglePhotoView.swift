//
//  SinglePhotoView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/21/23.
//

import SwiftUI

struct SinglePhotoView: View {
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack {
            Image(uiImage: photoInfo.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text("Keyword: \(photoInfo.keyword)")
                .padding()
            
            Text("Prompt: \(photoInfo.prompt)")
                .padding()
        }
        .navigationTitle("Photo Details")
    }
}
