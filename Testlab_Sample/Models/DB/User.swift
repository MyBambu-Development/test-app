//
//  User.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import Foundation

struct User: Identifiable, Codable {
    //Where the user is defined
    let id: UUID
    let first_name: String
    let last_name: String
    let email: String
    let created_at: Date?
}
