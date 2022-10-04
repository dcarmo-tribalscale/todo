//
//  ToDoApp.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import SwiftUI
import ToDoDatabase

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {

  var database: DBEngine!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

    database = FirebaseDBEngine()
    database.setup()

    return true
  }
}

// MARK: - App

@main
struct ToDoApp: App {

  // MARK: - Properties

  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  // MARK: - Body

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
