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
    
    let supabase = SupabaseManager.shared.supabase
    
    
    
    
    // Create Account
    func createUser(withEmail email: String, password: String, firstName: String, lastName: String) async throws {
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
            //Sets autheticated to true and logs user in
            isAuthenticated = true
            print("✅ User successfully created and added to Supabase")
            
            Task {
                await registerUserInPrizePool(email: email, userID: authUser.id.uuidString)
            }
        } catch {
            print("❌ Error signing up: \(error.localizedDescription)")
        }
    }
    
    //Register the user for Prizepool
    func registerUserInPrizePool(email: String, userID: String) async {
        do {
            // Call PrizePool API to create a user
            let responseString = try await PrizePoolServiceModel.createPrizePoolUser(for: email)
            
            // Convert response string to Data
            guard let data = responseString.data(using: .utf8) else {
                print("❌ Error: Could not convert responseString to Data")
                return
            }
            
            // Decode API Response
            let prizePoolUser = try JSONDecoder().decode(PrizePoolUserResponse.self, from: data)
            print("PrizePool API Response Decoded: \(prizePoolUser)")
            
            // Insert into `prizepool` table
            try await supabase
                .from("prizepool")
                .insert([
                    "user_id": userID,
                    "prizepool_user_id": prizePoolUser.user_id
                ])
                .execute()
            
            print("✅ PrizePool user successfully added to Supabase: \(prizePoolUser.user_id)")
            
        } catch {
            print("❌ Error registering user in PrizePool: \(error.localizedDescription)")
        }
    }
    
    
    // Sign In
    func signIn(withEmail email: String, password: String) async throws{
        do {
            let authResponse = try await supabase.auth.signIn(email: email, password: password)
            isAuthenticated = true
            print("✅ User signed in: \(authResponse.user.id)")
            
        } catch {
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
    
    func getCurrentUserID() async -> String? {
        do {
            let user = try await supabase.auth.user()
            return user.id.uuidString
        } catch {
            print("❌ Error fetching current user ID: \(error.localizedDescription)")
            return nil
        }
    }
}
