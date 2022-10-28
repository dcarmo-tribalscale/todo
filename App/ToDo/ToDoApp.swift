//
//  ToDoApp.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import SwiftUI
import ToDoDatabase
import FirebaseCore
import UIKit

enum ShortcutAction: String {
  case addTodo = "AddTodo"
}

// TODO: Need system to manage this
var shortcutAction: ShortcutAction?

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    if let shortcutItem = options.shortcutItem {
      shortcutAction = ShortcutAction(rawValue: shortcutItem.type)
    }

    let configuration = UISceneConfiguration(
      name: connectingSceneSession.configuration.name,
      sessionRole: connectingSceneSession.role
    )
    configuration.delegateClass = SceneDelegate.self
    return configuration
  }
}

// MARK: - SceneDelegate

class SceneDelegate: NSObject, UIWindowSceneDelegate {

  func windowScene(_ windowScene: UIWindowScene,
                   performActionFor shortcutItem: UIApplicationShortcutItem,
                   completionHandler: @escaping (Bool) -> Void
  ) {
    shortcutAction = ShortcutAction(rawValue: shortcutItem.type)
    completionHandler(true)
  }
}

// MARK: - App

@main
struct ToDoApp: App {

  // MARK: - Properties

  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  // MARK: - Lifecycle

  init() {
    let auth = FirebaseAuthEngine.shared
    auth.configure()
    auth.setup()

    let database = FirebaseDBEngine.shared
    database.setup(authEngine: auth)
  }

  // MARK: - Body

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
