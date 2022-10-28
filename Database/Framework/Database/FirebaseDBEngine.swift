//
//  FirestoreDBEngine.swift
//  Database
//
//  Created by TribalScale on 2022-10-04.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseDatabaseSwift
import ToDoShared
import Combine

public final class FirebaseDBEngine {

  // MARK: - Properties

  private let todoTableName = "todos"

  private let databaseRef: DatabaseReference = Database.database().reference()

  private var authEngine: AuthEngine?

  public static let shared: DBEngine = FirebaseDBEngine()

  // MARK: - Lifecycle

  private init() { }
}

// MARK: - Configurable

extension FirebaseDBEngine {

  public func configure() {
    FirebaseApp.configure()
  }
  
}

// MARK: - DBEngine

extension FirebaseDBEngine: DBEngine {

  public func setup(authEngine: AuthEngine) {
    self.authEngine = authEngine
  }

  public func getTodos() async throws -> [Todo] {
    return try await getTodos(count: nil)
  }

  public func getTodos(count: UInt? = nil) async throws -> [Todo] {
    guard let currentUser = authEngine?.currentUser else { return [] }

    let dbRef = databaseRef
      .child(todoTableName)
      .child(currentUser.uid)

    let snapshot: DataSnapshot
    if let count {
      snapshot = try await dbRef.queryLimited(toFirst: count).getData()
    } else {
      snapshot = try await dbRef.getData()
    }

    guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
      return []
    }

    return try children.map { childSnapshot in
      try childSnapshot.data(as: Todo.self)
    }
  }

  public func save(todo: Todo) async throws {
    guard let currentUser = authEngine?.currentUser else { return }

    try databaseRef
      .child(todoTableName)
      .child(currentUser.uid)
      .child(todo.id)
      .setValue(from: todo)
  }

  public func delete(todo: Todo) async throws {
    guard let currentUser = authEngine?.currentUser else { return }

    try await databaseRef
      .child(todoTableName)
      .child(currentUser.uid)
      .child(todo.id)
      .removeValue()
  }

  public func updateComplete(on todo: Todo) async throws {
    guard let currentUser = authEngine?.currentUser else { return }

    try await databaseRef
      .child(todoTableName)
      .child(currentUser.uid)
      .child(todo.id)
      .updateChildValues([
        "complete": todo.complete,
        "updatedAt": todo.updatedAt
      ])
  }
}
