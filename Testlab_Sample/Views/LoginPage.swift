//
//  LoginPage.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("bambu_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24) {
                    TextInput(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com",
                              accessibilityLabel: "emailLoginTextField")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    TextInput(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              accessibilityLabel: "passwordLoginTextField",
                              isSecureField: true
                              )
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    Task {
                        //Calls signIn fucntion in AuthViewModel
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .accessibilityIdentifier("signInButton")
                .background(Color(.systemBlue))
                .disabled(!formIsVaild)
                .opacity(formIsVaild ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                //Nav link to sign up page 
                NavigationLink {
                    RegistrationPage()
                        .navigationBarBackButtonHidden(true)
                } label : {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

//Field rules for form validation
extension LoginPage: AuthenticationFormProtocol {
    var formIsVaild: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

