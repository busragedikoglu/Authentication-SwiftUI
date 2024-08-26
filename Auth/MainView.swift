//
//  MainView.swift
//  Auth
//
//  Created by Büşra Gedikoğlu on 22.08.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authModel: AuthModel

        var body: some View {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 50)

                Spacer()

                Button(action: {
                    authModel.signOut()
                }) {
                    Text("Log Out")
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.white.ignoresSafeArea())
        }
    }

    #Preview {
        MainView()
            .environmentObject(AuthModel())
    }
