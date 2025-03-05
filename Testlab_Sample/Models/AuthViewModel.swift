//
//  AuthViewModel.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import Supabase
import SwiftUI

protocol AuthenticationFormProtocol {
    var formIsVaild: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?

    let supabase = SupabaseManager.shared.supabase

    // Create Account
    func createUser(withEmail email: String, password: String, firstName: String, lastName: String) async {
        do {
            // Register User in Supabase Auth
            let authResponse = try await supabase.auth.signUp(email: email, password: password)
            let authUser = authResponse.user // Extract Authenticated User

            // Create a User Model
            let newUser = User(
                id: authUser.id,
                first_name: firstName,
                last_name: lastName,
                email: authUser.email ?? email,
                created_at: Date()
            )

            // Insert User Data into Supabase Database
            try await supabase
                .from("users")
                .insert(newUser)
                .execute()
            
            isAuthenticated = true
            print("✅ User successfully created and added to Supabase")
            
            do {
                let response = try await PrizePoolServiceModel.postUserUpdate(for: email)
                print("✅ User successfully added to Prizepool: \(response)")
            } catch {
                print("❌ Error adding user to Prizepool: \(error.localizedDescription)")
            }

        } catch {
            self.errorMessage = error.localizedDescription
            print("❌ Error signing up: \(error.localizedDescription)")
        }
    }

    // Sign In
    func signIn(withEmail email: String, password: String) async {
        do {
            let authResponse = try await supabase.auth.signIn(email: email, password: password)
            isAuthenticated = true
            print("✅ User signed in: \(authResponse.user.id)")
        } catch {
            self.errorMessage = error.localizedDescription
            print("❌ Error signing in: \(error.localizedDescription)")
        }
    }

    // Sign Out
    func signOut() async {
        do {
            try await supabase.auth.signOut()
            isAuthenticated = false
            print("✅ User signed out")
        } catch {
            print("❌ Error signing out: \(error.localizedDescription)")
        }
    }
}
