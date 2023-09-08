//
//  ContentViewModel.swift
//  ArtiPic
//
//  Created by Dream K on 8/13/23.
//

import Foundation
import Firebase
import Combine
import FirebaseAuth

class ContentViewModel: ObservableObject{
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        setupSubscribers()
    }
    
    func setupSubscribers(){
        service.$userSession
            .receive(on: DispatchQueue.main)  // Ensure updates are on the main thread (related wit @MainActor)
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }
            .store(in: &cancellables)
        
        service.$currentUser
            .receive(on: DispatchQueue.main)  // Ensure updates are on the main thread (related wit @MainActor)
            .sink { [weak self] currentUser in
                self?.currentUser = currentUser
            }
            .store(in: &cancellables)
    }
    
}
