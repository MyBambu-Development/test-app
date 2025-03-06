//
//  HomePage.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var count = 0
    
    var body: some View {
        
        
        VStack {
            //Code for MyBambu logo
            Image("bambu_logo")
                .imageScale(.large)
                .foregroundStyle(.tint)
    
            //Link to PrizePool
            NavigationLink("Spin the Wheel!", destination: GamePage())
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            
            Text("Count: \(count)")
                .padding()
                .accessibilityIdentifier("countLabel")
            //Increment Button code
            Button("Press Me!") {
                //Each click increments count by 1
                count += 1
            }
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("incrementButton")
            
            //Button code
            Button("Reset") {
                //Resets count to 0
                count = 0
            }
            .buttonStyle(.bordered)
            .accessibilityIdentifier("resetButton")
            .padding()
            //Sign out Button
            Button("Sign Out") {
                Task{
                   await viewModel.signOut()
                }
            }
        }
        .padding()
    }
}


