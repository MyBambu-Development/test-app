//
//  WelcomePage.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // Your app's logo or any welcome text can go here
                Image("bambu_logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome to My App!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Spacer()
                // Navigation to LoginView
                NavigationLink(destination: LoginPage(), label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .accessibilityIdentifier("welcomeLogin")
                })
                // Navigation to SignupView
                NavigationLink(destination: RegistrationPage(), label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .accessibilityIdentifier("welcomeSignup")
                })
                Spacer()
            }
            .padding()
        }
    }
}


