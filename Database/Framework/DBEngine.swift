//
//  DBEngine.swift
//  Database
//
//  Created by TribalScale on 2022-10-04.
//

import Combine
import Foundation
import ToDoAuth
import ToDoShared

public protocol DBEngine: AnyObject, Sendable {
  func setup(authEngine: AuthEngine)
  func getTodos() async throws -> [Todo]
  func getTodos(count: UInt?) async throws -> [Todo]
  func save(todo: Todo) async throws
  func delete(todo: Todo) async throws
  func updateComplete(on todo: Todo) async throws
}
