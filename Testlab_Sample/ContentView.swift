//
//  ContentView.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/19/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                HomePage() // Redirect to HomePage after login
            } else {
                WelcomePage() // Show WelcomePage if not logged in
            }
        }
    }
}



