//
//  FirestoreDBEngine.swift
//  Database
//
//  Created by TribalScale on 2022-10-04.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import ToDoShared

public final class FirebaseDBEngine: DBEngine {

  private lazy var databaseRef: DatabaseReference = {
    Database.database().reference()
  }()

  public init() { }

  public func setup() {
    FirebaseApp.configure()
  }

  public func getTodos() async throws -> Any? {
    let snapshot = try await databaseRef.child("todos").getData()
    // TODO: Get the Todos out of here
    return snapshot.value
  }

  public func saveTodo(todo: Todo) throws {
    let data = try JSONEncoder().encode(todo)
    let json = try JSONSerialization.jsonObject(with: data)
    databaseRef.child("todos").childByAutoId().setValue(json)
  }

}
