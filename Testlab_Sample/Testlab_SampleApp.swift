//
//  Testlab_SampleApp.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 2/19/25.
//

import SwiftUI

@main
struct YourApp: App {

    @StateObject var viewModel = AuthViewModel()
    @StateObject private var errorManager = GlobalErrorManager()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
      .environmentObject(viewModel)
      .environmentObject(errorManager)
    }
  }
}
