//
//  ProfileView.swift
//  ArtiPic
//
//  Created by Dream K on 8/12/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
//    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3)-1
    
//    var posts: [Post] {
//        return Post.MOCK_POSTS.filter { post in
//            post.user?.username == user.username
//        }
//    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                // header
                VStack(spacing: 10) {
                    // pic
                    HStack {
                        Image(user.profileImageUrl ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 16)
                    
                    
                    // username and bio
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.bio ?? "")
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                    
                    
                    // action button
                    Button {
                        
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 360, height: 34)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    
                    
                    Divider()
                }
                
                // post grid view
//                PostGridView(posts: posts)
                    
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Text(user.username)
                                    .font(.headline)
                                    .padding(.horizontal, 6)
                                )
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        
                    }label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0])
    }
}
