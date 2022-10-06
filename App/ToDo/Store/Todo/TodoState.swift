//
//  Store.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift
import ToDoShared

// MARK: - State

struct TodoState {
  /// Holds the todo items
  var items: [Todo]

  /// Holds the items that are currently in the process of being sync'd to the server
  var itemsSyncState: [Todo.ID: SyncState]
}

// MARK: - CustomDebugStringConvertible

extension TodoState: CustomDebugStringConvertible {
  var debugDescription: String {
    return """
TodoState {
  items:
    \(items.debugDescription)
  itemsSyncState:
    \(itemsSyncState.debugDescription)
}
"""
  }
}

// MARK: - SyncState

enum SyncState: String {
  /// Item is in process of syncing
  case syncing
  /// Item has sync'd successfully
  case complete
  /// Item has failed to sync
  case failed
}

// MARK: - CustomDebugStringConvertible

extension SyncState: CustomDebugStringConvertible {
  var debugDescription: String {
    return self.rawValue
  }
}
