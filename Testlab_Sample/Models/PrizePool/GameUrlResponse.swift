//
//  GameUrlResponse.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 3/6/25.
//


import Foundation

struct GameUrlResponse: Codable {
    let status: String
    let url: String
    let lang: String
    let expiry_time: String
}
