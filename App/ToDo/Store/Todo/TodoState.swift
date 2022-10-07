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

enum SyncState {
  /// Item is in process of syncing
  case syncing
  /// Item has sync'd successfully
  case complete
  /// Item has failed to sync
  case failed
  /// Item has failed and we want to allow the user to retry
  case retry(block: () -> Void)
}

// MARK: - CustomDebugStringConvertible

extension SyncState: CustomDebugStringConvertible {
  var debugDescription: String {
    switch self {
    case .syncing: return "syncing"
    case .complete: return "complete"
    case .failed: return "failed"
    case .retry: return "retry"
    }
  }
}

// MARK: - Equatable

extension SyncState: Equatable {
  static func == (_ lhs: SyncState, _ rhs: SyncState) -> Bool {
    switch (lhs, rhs) {
    case (.syncing, .syncing)
      , (.complete, .complete)
      , (.failed, .failed)
      , (.retry, .retry):
      return true
    default:
      return false
    }
  }
}

// MARK: - Hashable

extension SyncState: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(self)
  }
}
