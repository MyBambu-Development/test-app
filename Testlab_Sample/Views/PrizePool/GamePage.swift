//
//  GamePage.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 3/6/25.
//

import SwiftUI
import WebKit

struct GamePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var gameURL: URL?
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let gameURL = gameURL {
                WebView(url: gameURL) // Load game in WebView
            } else if isLoading {
                ProgressView("Loading Game...") //Show loading indicator
            } else {
                //If game fails to load show error
                Text(errorMessage ?? "Failed to load game.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            Task {
                await fetchGameURL()
            }
        }
    }

    //Fetch PrizePool User ID & Call API for Game URL
    private func fetchGameURL() async {
        //Gets UUID from current loged in user
        do {
            guard let userID = await viewModel.getCurrentUserID() else {
                errorMessage = "User not authenticated."
                isLoading = false
                return
            }

            // Fetch PrizePool User ID from Supabase
            let response = try await viewModel.supabase
                .from("prizepool")
                .select("prizepool_user_id")
                .match(["user_id": userID])
                .execute()


            //Decodes json response from DB
            let decodedResponse = try JSONDecoder().decode([PrizePoolUserID].self, from: response.data)
            //Extracts prizepool_user_id
            guard let prizepoolUserID = decodedResponse.first?.prizepool_user_id else {
                errorMessage = "No PrizePool user ID found."
                isLoading = false
                return
            }
            
            // Call API to Get Game URL
            let gameURLString = try await PrizePoolServiceModel.playGame(for: prizepoolUserID)

            // Convert String to URL
            if let url = URL(string: gameURLString) {
                //set gameURL to prizepool URL
                DispatchQueue.main.async {
                    self.gameURL = url
                    self.isLoading = false
                }
            } else {
                errorMessage = "Invalid game URL."
                isLoading = false
            }

        } catch {
            errorMessage = "Error fetching game: \(error.localizedDescription)"
            isLoading = false
        }
    }
}
