//
//  Store.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift
import ToDoShared

struct TodoState {
  /// Holds the todo items
  var items: [Todo]

  /// Holds the items that are currently in the process of being sync'd to the server
  var itemsSyncState: [Todo: SyncState]
}

enum SyncState {
  /// Item is in process of syncing
  case syncing
  /// Item has sync'd successfully
  case complete
  /// Item has failed to sync
  case failed
}
