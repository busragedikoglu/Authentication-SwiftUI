//
//  Model.swift
//  Auth
//
//  Created by Büşra Gedikoğlu on 25.08.2024.
//

import Combine
import SwiftUI

class AuthModel: ObservableObject {
    //ObservableObject: arayüz değişikliklerini otomatik olarak gözlemler
    //@Published: veri akışı için kullanıldı(Combine)
    @Published var currentUser: User? = nil
    @Published var isAuthenticated: Bool = false

    private var users: [User] = []

    init() {
        loadUsers() // İlk çalışır. Kaydedilmiş kullanıcıları belleğe yükler.
    }

    func signUp(name: String, email: String, password: String) {
        guard !users.contains(where: { $0.email == email }) else {
            print("Email already in use.")
            return
        }

        let newUser = User(name: name, email: email, password: password)
        users.append(newUser)
        saveUsers()
        isAuthenticated = true
        currentUser = newUser
    }


    func signIn(email: String, password: String) -> Bool {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            isAuthenticated = true
            currentUser = user
            return true
        } else {
            return false
        }
    }

    func signOut() {
        isAuthenticated = false
        currentUser = nil
    }

    private func saveUsers() {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: "users")
        }
    }

    private func loadUsers() {
        if let savedUsers = UserDefaults.standard.data(forKey: "users") {
            if let loadedUsers = try? JSONDecoder().decode([User].self, from: savedUsers) {
                users = loadedUsers
            }
        }
    }
}

struct User: Identifiable, Codable{
    var id = UUID()
    var name: String
    var email: String
    var password: String
}
