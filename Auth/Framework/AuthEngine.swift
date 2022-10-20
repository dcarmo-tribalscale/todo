//
//  AuthEngine.swift
//  ToDoAuth
//
//  Created by TribalScale on 2022-10-11.
//

import Foundation
import Combine
import FirebaseAuth

public protocol AuthEngine {

  var isLoggedIn: CurrentValueSubject<Bool, Never> { get }
  var currentUser: User? { get }

  func setup()

  func signUp(email: String, password: String) async throws
  func signIn(email: String, password: String) async throws
  func signOut() throws
}
