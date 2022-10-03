//
//  ToDoApp.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import SwiftUI
import TodoDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    TodoDatabase.register()

    return true
  }
}

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
