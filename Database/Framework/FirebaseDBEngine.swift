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

public final class FirebaseDBEngine: DBEngine {

  private let todoTableName = "todos"

  private lazy var databaseRef: DatabaseReference = {
    Database.database().reference()
  }()

  public init() { }

  public func setup() {
    FirebaseApp.configure()
  }

  public func getTodos() async throws -> [Todo] {
    let snapshot = try await databaseRef.child(todoTableName).getData()
    guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
      return []
    }

    return try children.map { childSnapshot in
      try childSnapshot.data(as: Todo.self)
    }
  }

  public func save(todo: Todo) async throws {
    try databaseRef
      .child(todoTableName)
      .child(todo.id)
      .setValue(from: todo)
  }

  public func delete(todo: Todo) async throws {
    try await databaseRef
      .child(todoTableName)
      .child(todo.id)
      .removeValue()
  }

  public func updateCompleted(todoId: Todo.ID, complete: Bool) async throws {
    try await databaseRef
      .child(todoTableName)
      .child(todoId)
      .updateChildValues(["complete": complete])
  }
}
