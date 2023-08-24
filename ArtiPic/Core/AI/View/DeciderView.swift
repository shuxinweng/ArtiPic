//
//  DeciderView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/23/23.
//

import SwiftUI

struct DeciderView: View {
    let user: User
    
    var body: some View {
        Group{
            if user.isVIP == false {
                VIPView()
            }
            else if user.isVIP == true {
                AIView()
            }
        }
    }
}

struct DeciderView_Previews: PreviewProvider {
    static var previews: some View {
        DeciderView(user: User.MOCK_USERS[0])
    }
}
