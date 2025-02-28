//
//  RegistrationPage.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import SwiftUI

struct RegistrationPage: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
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
                          accessibilityLabel: "emailRegistration")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                TextInput(text: $fullname,
                          title: "Full Name",
                          placeholder: "Enter your name",
                          accessibilityLabel: "fullNameRegistration")
                
                TextInput(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          accessibilityLabel: "passwordRegistration",
                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    TextInput(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password",
                              accessibilityLabel: "confirmPasswordRegistration",
                              isSecureField: true)
                    
                    if !password.isEmpty && confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullname: fullname)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsVaild)
            .opacity(formIsVaild ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            NavigationLink {
                LoginPage()
                    .navigationBarBackButtonHidden(true)
            } label : {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .font(.system(size: 14))
            }
        }
    }
}

//Field rules for form validation
extension RegistrationPage: AuthenticationFormProtocol {
    var formIsVaild: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}



