//
//  MainTabView.swift
//  ArtiPic
//
//  Created by Dream K on 8/12/23.
//

import SwiftUI

class TabViewModel: ObservableObject {
    @Published var selectedIndex = 0
}

struct MainTabView: View {
    @StateObject private var tabViewModel = TabViewModel()
    
    var body: some View {
        TabView(selection: $tabViewModel.selectedIndex){
            PhotoView()
                .tabItem {
                    Image(systemName: "photo.stack")
                }.tag(0)

            AIView()
                .tabItem {
                    Image(systemName: "paintbrush.pointed.fill")
                }.tag(1)

            CollectionView()
                .tabItem {
                    Image(systemName: "bookmark")
                }.tag(2)

            ProfileView(user: User.MOCK_USERS[0])
                .tabItem {
                    Image(systemName: "person")
                }.tag(3)
        }
        .accentColor(.black)
        .environmentObject(tabViewModel)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
