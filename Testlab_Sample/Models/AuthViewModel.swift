//
//  AuthViewModel.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

//Protocol for form validation
protocol AuthenticationFormProtocol {
    var formIsVaild: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: String?

    
    init() {
        //Sets user session to currently logged in user
        self.userSession = Auth.auth().currentUser
        
        Task {
            //Async to fetch user info to check user status (signed in or not)
            await fetchUser()
        }
    }
    

    
    //Sign in function
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Debug: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    //Create new user function
    func createUser(withEmail email: String, password: String, fullname: String, errorManager: GlobalErrorManager) async throws {
            do {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                self.userSession = result.user
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription //Show inline error
                    errorManager.showError(title: "Registration Error", message: error.localizedDescription) //Show alert
                }
                throw error
            }
        }
    
    
    //Sign out function
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Debug: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    func fetchUser() async {
        //If user is not signed in function returns early
        guard let uid = Auth.auth().currentUser?.uid else {
            print("⚠️ No user is currently signed in.")
            return
        }

        do {
            //Fetchs user and saves them as a User model
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            
            if snapshot.exists {
                self.currentUser = try snapshot.data(as: User.self)
                print("Successfully fetched user: \(String(describing: currentUser))")
            } else {
                print("User does not exist in Firestore.")
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
    }

    
}
