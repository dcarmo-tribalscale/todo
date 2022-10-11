//
//  Actions.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import Foundation
import ReSwift
import ToDoShared

public enum TodoAction: Action {
  /// Create a single Todo
  case create(todo: Todo)

  /// Update a single Todo
  case update(todo: Todo)

  /// Delete a single Todo
  case delete(id: Todo.ID)

  /// Save a bulk amount of Todos
  case save(todos: [Todo])

  /// Update the todo complete state
  case updateComplete(todo: Todo)

  /// Update the state of a single Todo being sync'd to the server
  case updateSyncState(id: Todo.ID, syncState: SyncState)

  /// Remove the sync state from the todo
  case removeSyncState(id: Todo.ID)
}

extension TodoAction: TimestampedAction {
  func timestampUpdatedAction() -> TodoAction {
    switch self {
    case let .update(todo):
      var updatedTodo = todo
      updatedTodo.updatedAt = Date().timeIntervalSince1970
      return .update(todo: updatedTodo)

    case let .updateComplete(todo):
      var updatedTodo = todo
      updatedTodo.updatedAt = Date().timeIntervalSince1970
      return .updateComplete(todo: updatedTodo)

    default:
      return self
    }
  }
}
