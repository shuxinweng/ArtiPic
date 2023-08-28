//
//  ImageView.swift
//  ArtiPic
//
//  Created by Dream K on 8/27/23.
//

import SwiftUI
import Kingfisher

enum ImageSize{
    case xSmall
    case small
    case medium
    case large
    
    var dimension: CGFloat{switch self {
    case .xSmall:
        return 40
    case .small:
        return 48
    case .medium:
        return 64
    case .large:
        return 80
    }}
}

struct RegularImageView: View {
    let photo: Photo
    let size: ImageSize
    
    var body: some View {
        let imageUrl = photo.imageUrl
        KFImage(URL(string:  imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: size.dimension, height: size.dimension)
            .clipShape(Circle())
    }
}

struct RegularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
    }
}
