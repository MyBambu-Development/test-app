//
//  TextInput.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/27/25.
//

import SwiftUI

struct TextInput: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let accessibilityLabel: String?
    var isSecureField = false
    //Reusable component for text fields
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
                .accessibilityIdentifier(accessibilityLabel ?? "")
            //If secure field set text field to secure field
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .accessibilityIdentifier(accessibilityLabel ?? "")
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .accessibilityIdentifier(accessibilityLabel ?? "")
            }
            
            Divider()
        }
    }
}


