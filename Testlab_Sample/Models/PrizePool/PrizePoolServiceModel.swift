//
//  PrizePoolServiceModel.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 3/5/25.
//

import Foundation

struct PrizePoolServiceModel {
    static let baseURL = ProcessInfo.processInfo.environment["API_BASE_URL"] ?? "testurl"
    
    static func createPrizePoolUser(for username: String) async throws -> String {
        // Set the URL
        guard let url = URL(string: "\(baseURL)/users") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Fetch API Key from Environment
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "default-key"

        // Add Headers
        request.setValue("mybambu", forHTTPHeaderField: "X-Organization-ID")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Set the JSON Body
        let parameters: [String: Any] = ["external_reference": username]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)


        // Perform API Call
        let (data, response) = try await URLSession.shared.data(for: request)

        let responseString = String(data: data, encoding: .utf8) ?? "No response data"
        print("PrizePool API Response: \(responseString)")

        //Ensure HTTP 201 Response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }

        return responseString
    }
    
    //Gets the game url for Users
    static func playGame(for prizePoolUserID: String) async throws -> String {
        // Set the URL
        guard let url = URL(string: "\(baseURL)/users/\(prizePoolUserID)/games/play") else {
               throw URLError(.badURL)
           }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Fetch API Key from Environment
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "default-key"
        
        // Add Headers
        request.setValue("mybambu", forHTTPHeaderField: "X-Organization-ID")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform API Call
        let (data, response) = try await URLSession.shared.data(for: request)
        
        //Ensure HTTP 200 Response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        
        let gameResponse = try JSONDecoder().decode(GameUrlResponse.self, from: data)
        print("Game URL response: \(gameResponse)")
        
        return gameResponse.url
    }
    
}
