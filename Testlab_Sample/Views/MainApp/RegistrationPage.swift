//
//  RegistrationPage.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import SwiftUI

struct RegistrationPage: View {
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
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
                // Email Input
                TextInput(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com",
                          accessibilityLabel: "emailRegistration")
                .autocapitalization(.none)
                
                // Full Name Input
                TextInput(text: $firstName,
                          title: "First Name",
                          placeholder: "Enter your first name",
                          accessibilityLabel: "firstNameRegistration")
                
                // Last Name Input
                TextInput(text: $lastName,
                          title: "Last Name",
                          placeholder: "Enter your last name",
                          accessibilityLabel: "lastNameRegistration")
                
                // Password Input
                TextInput(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          accessibilityLabel: "passwordRegistration",
                          isSecureField: true)
                
                // Confirm Password Input with Fix
                ZStack(alignment: .trailing) {
                    TextInput(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password",
                              accessibilityLabel: "confirmPasswordRegistration",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: password == confirmPassword ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(password == confirmPassword ? .green : .red)
                            .padding(.trailing, 8)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            // SIGN UP BUTTON
            Button {
                Task {
                    do {
                        try await viewModel.createUser(
                            withEmail: email,
                            password: password,
                            firstName: firstName,
                            lastName: lastName
                        )
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
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
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            // LOGIN NAVIGATION
            NavigationLink {
                LoginPage()
                    .navigationBarBackButtonHidden(true)
            } label : {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
    
    //Form validation logic
    var formIsValid: Bool {
        return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
            && confirmPassword == password
            && !firstName.isEmpty
            && !lastName.isEmpty
    }
}



