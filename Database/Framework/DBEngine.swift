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
  func saveTodo(todo: Todo) async throws
}
