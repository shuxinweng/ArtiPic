//
//  RegistrationViewModel.swift
//  ArtiPic
//
//  Created by Dream K on 8/13/23.
//

import Foundation


class RegistrationViewModel: ObservableObject{
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isVIP = false
    
    @MainActor
    func createUser() async throws{
        try await AuthService.shared.createUser(email: email, password: password, username: username, isVIP: isVIP)
        
        username = ""
        email = ""
        password = ""
    }
}
