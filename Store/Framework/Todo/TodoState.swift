//
//  Store.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift
import ToDoShared

// MARK: - State

public struct TodoState {
  /// Holds the todo items
  public var items: [Todo]

  /// Holds the items that are currently in the process of being sync'd to the server
  public var itemsSyncState: [Todo.ID: SyncState]
}

// MARK: - CustomDebugStringConvertible

extension TodoState: CustomDebugStringConvertible {
  public var debugDescription: String {
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
