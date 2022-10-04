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
  func getTodos() async throws -> Any?
  func saveTodo(todo: Todo) throws
}
