//
//  MainTabView.swift
//  ArtiPic
//
//  Created by Dream K on 8/12/23.
//

import SwiftUI

struct MainTabView: View {
    let user:User
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex){
            CategoryView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "photo.stack")
                }.tag(0)

            DeciderView(user: user)
//            AIView()
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "paintbrush.pointed.fill")
                }.tag(1)

            CollectionView()
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "bookmark")
                }.tag(2)

            ProfileView(user: user)
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(3)
        }
        .accentColor(.black)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: User.MOCK_USERS[0])
    }
}
