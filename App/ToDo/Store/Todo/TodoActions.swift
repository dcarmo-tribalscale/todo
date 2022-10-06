//
//  Actions.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import Foundation
import ReSwift
import ToDoShared

enum TodoAction: Action {
  /// Create a single Todo
  case create(todo: Todo)

  /// Update a single Todo
  case update(todo: Todo)

  /// Delete a single Todo
  case delete(id: Todo.ID)

  /// Save a bulk amount of Todos
  case save(todos: [Todo])

  /// Toggle todo completed state
  case toggleCompleted(todo: Todo)

  /// Update the state of a single Todo being sync'd to the server
  case updateSyncState(todo: Todo, syncState: SyncState)

  /// Remove the sync state from the todo
  case removeSyncState(todo: Todo)
}

extension TodoAction: TimestampedAction {
  func timestampUpdatedAction() -> TodoAction {
    switch self {
    case let .update(todo):
      var updatedTodo = todo
      updatedTodo.updatedAt = Date().timeIntervalSince1970
      return .update(todo: updatedTodo)

    default:
      return self
    }
  }
}
