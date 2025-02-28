//
//  ContentView.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/19/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            //If User is logged in show home page
            if viewModel.userSession != nil {
                HomePage()
            } else {
                //Else show welcome page
                WelcomePage()
            }
        }
    }
}


