//
//  CategoryView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/21/23.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                NavigationLink(destination: PhotoView()) {
                    Text("Photo")
                }
                
                Spacer()
                
                NavigationLink(destination: PeopleView()) {
                    Text("People")
                }
                
                Spacer()
                
                NavigationLink(destination: PlantView()) {
                    Text("Plant")
                }
                
                Spacer()
                
                NavigationLink(destination: OtherView()) {
                    Text("Other")
                }
                
                Spacer()
            }
            .navigationBarTitle("Categories")
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
