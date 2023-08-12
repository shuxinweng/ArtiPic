//
//  MainTabView.swift
//  ArtiPic
//
//  Created by Dream K on 8/12/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Photo")
                .tabItem {
                    Image(systemName: "photo.stack")
                }
            
            Text("AI")
                .tabItem {
                    Image(systemName: "paintbrush.pointed.fill")
                }
            
            Text("Collection")
                .tabItem {
                    Image(systemName: "bookmark")
                }
            
            ProfileView(user: User.MOCK_USERS[0])
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(.black)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
