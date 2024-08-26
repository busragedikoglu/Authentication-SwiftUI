//
//  AuthApp.swift
//  Auth
//
//  Created by Büşra Gedikoğlu on 21.08.2024.
//

import SwiftUI

@main
struct AuthApp: App {
    @StateObject private var authModel = AuthModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authModel)
        }
    }
}
