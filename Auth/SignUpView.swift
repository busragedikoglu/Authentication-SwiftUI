//
//  SignUpView.swift
//  Auth
//
//  Created by Büşra Gedikoğlu on 25.08.2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authModel: AuthModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Create an Account!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 100)

                inputField(icon: "person", placeholder: "Name", text: $name, isSecure: false)
                inputField(icon: "mail", placeholder: "Email", text: $email, isSecure: false, keyboardType: .emailAddress)
                inputField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)

                Button(action: {
                    dismiss()
                }) {
                    Text("Already have an account?")
                        .font(.callout)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.top)

                Spacer()

                Button(action: {
                    authModel.signUp(name: name, email: email, password: password)
                    dismiss()
                }) {
                    Text("Create New Account")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .padding()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
        }
    }

    private func inputField(icon: String, placeholder: String, text: Binding<String>, isSecure: Bool, keyboardType: UIKeyboardType = .default) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(.leading, 8)
            if isSecure {
                SecureField(placeholder, text: text)
                    .foregroundColor(.white)
                    .padding(14)
            } else {
                TextField(placeholder, text: text)
                    .foregroundColor(.gray)
                    .padding(14)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .background(Color.black)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthModel())
}
