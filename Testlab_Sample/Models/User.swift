//
//  User.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import Foundation

struct User: Identifiable, Codable {
    //Where the user is defined
    let id: String
    let fullname: String
    let email: String
}
