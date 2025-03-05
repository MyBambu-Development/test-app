//
//  GlobalErrorManager.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 3/3/25.
//

import SwiftUI

// Error Button Configuration (Optional Actions)
struct ErrorButtonConfig {
    let title: String
    let action: (() -> Void)?
}

// Holds Error Information
struct ErrorPresentationConfig: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let primaryButton: ErrorButtonConfig?
    let secondaryButton: ErrorButtonConfig?
}

// ObservableObject to Control Errors in SwiftUI
class GlobalErrorManager: ObservableObject {
    @Published var currentError: ErrorPresentationConfig?

    // Show Simple Error Message
    func showError(title: String = "Error", message: String = "An unexpected error occurred.") {
        currentError = ErrorPresentationConfig(title: title, message: message, primaryButton: nil, secondaryButton: nil)
    }

    // Show Error with Buttons
    func showError(title: String, message: String, primaryButton: ErrorButtonConfig?, secondaryButton: ErrorButtonConfig?) {
        currentError = ErrorPresentationConfig(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }

    // Dismiss Error
    func dismissError() {
        currentError = nil
    }
}
