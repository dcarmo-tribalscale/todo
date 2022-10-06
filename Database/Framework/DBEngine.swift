//
//  DBEngine.swift
//  Database
//
//  Created by TribalScale on 2022-10-04.
//

import Foundation
import ToDoShared

public protocol DBEngine: AnyObject {
  func setup()
  func getTodos() async throws -> [Todo]
  func save(todo: Todo) async throws
  func delete(todo: Todo) async throws
  func updateComplete(on todo: Todo) async throws
}
