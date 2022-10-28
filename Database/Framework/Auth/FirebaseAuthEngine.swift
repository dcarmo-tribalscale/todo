//
//  FirebaseAuthEngine.swift
//  ToDoAuth
//
//  Created by TribalScale on 2022-10-11.
//

import Combine
import Foundation
import FirebaseCore
import FirebaseAuth

public class FirebaseAuthEngine {

  // MARK: - Properties

  public var isLoggedIn = CurrentValueSubject<Bool, Never>(false)

  public static let shared: AuthEngine = FirebaseAuthEngine()

  private var stateChangedHandler: AuthStateDidChangeListenerHandle?

  // MARK: - Lifecycle

  public init() { }

  deinit {
    if let stateChangedHandler {
      Auth.auth().removeStateDidChangeListener(stateChangedHandler)
    }
  }

}

// MARK: - Configurable

extension FirebaseAuthEngine {

  public func configure() {
    FirebaseApp.configure()
  }

}

// MARK: - AuthEngine

extension FirebaseAuthEngine: AuthEngine {

  public func setup() {
    self.isLoggedIn.send(currentUser != nil)
    self.stateChangedHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self else { return }

      self.isLoggedIn.send(user != nil)
    }
  }

  public var currentUser: User? {
    Auth.auth().currentUser
  }

  public func signUp(email: String, password: String) async throws {
    let result = try await Auth.auth().createUser(withEmail: email, password: password)
    print(result)
  }

  public func signIn(email: String, password: String) async throws {
    let result = try await Auth.auth().signIn(withEmail: email, password: password)
    print(result)
  }

  public func signOut() throws {
    try Auth.auth().signOut()
  }

}
