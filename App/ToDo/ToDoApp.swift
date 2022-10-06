//
//  ToDoApp.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import SwiftUI
import ToDoDatabase

// MARK: - App

@main
struct ToDoApp: App {

  // MARK: - Properties

  // MARK: - Lifecycle

  init() {
    let database = FirebaseDBEngine()
    database.setup()
  }

  // MARK: - Body

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
