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

  public func getTodos() async throws -> [Todo] {
    let snapshot = try await databaseRef.child("todos").getData()
    if let snapshotValue = snapshot.value as? [String: [String: Any]] {
      return try convert(snapshotValue: snapshotValue, to: [Todo].self)
    }
    return []
  }

  public func saveTodo(todo: Todo) async throws {
    let data = try JSONEncoder().encode(todo)
    let json = try JSONSerialization.jsonObject(with: data)
    try await databaseRef.child("todos").child(todo.id).setValue(json)
  }

  /**
   Convert an array of elements from firebase to their codable object type.

   NOTE: This only works for flat objects. It cannot convert objects within objects that are keyed in firebase.
   */
  // swiftlint:disable:next line_length
  private func convert<T>(snapshotValue: [String: [String: Any]], to toType: T.Type) throws -> T where T: Sequence, T: Decodable, T.Element: Decodable, T.Element: Identifiable, T.Element.ID == String {
    var flattenedObjects = [[String: Any]]()
    snapshotValue.keys.forEach { key in
      var object = snapshotValue[key]!
      object["id"] = key
      flattenedObjects.append(object)
    }

    let data = try JSONSerialization.data(withJSONObject: flattenedObjects)
    return try JSONDecoder().decode(toType, from: data)
  }

  // swiftlint:disable:next line_length
  private func convert<T>(snapshotValue: [String: Any], to toType: T.Type) throws -> T where T: Codable, T: Identifiable, T.ID == String {
    let data = Data()
    return try JSONDecoder().decode(toType, from: data)
  }

}
