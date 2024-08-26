//
//  ContentView.swift
//  Auth
//
//  Created by Büşra Gedikoğlu on 21.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignUp: Bool = false
    @EnvironmentObject var authModel: AuthModel
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationStack {
            if authModel.isAuthenticated {
                MainView()
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Welcome Back!")
                        .font(.title)
                        .bold()

                    Spacer()
                    emailField
                    passwordField
                    signUpButton
                    Spacer()
                    signInButton
                }
                .padding()
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpView()
                }
            }
        }
        .tint(.white)
    }

    private var emailField: some View {
        HStack {
            Image(systemName: "mail")
                .foregroundColor(.black)
                .padding(.leading, 8)
            TextField("Email", text: $email)
                .padding(14)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .autocorrectionDisabled()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
        }
        .padding(.top)
    }

    private var passwordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.black)
                .padding(.leading, 8)
            SecureField("Password", text: $password)
                .padding(14)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
        }
        .padding(.bottom)
    }

    private var signUpButton: some View {
        Button(action: {
            showSignUp = true
        }) {
            Text("Don't have an account?")
                .font(.callout)
                .fontWeight(.regular)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }

    private var signInButton: some View {
        Button(action: {
            if email.isEmpty || password.isEmpty {
                alertMessage = "Email and Password cannot be empty."
                showAlert = true
            } else if !authModel.signIn(email: email, password: password) {
                alertMessage = "Authentication failed. Please check your credentials."
                showAlert = true
            }
        }) {
            Text("Sign In")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
        .padding(.top, 20)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthModel())
}
