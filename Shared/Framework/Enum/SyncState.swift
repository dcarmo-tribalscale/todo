//
//  SyncState.swift
//  ToDoStore
//
//  Created by TribalScale on 2022-10-07.
//

import Foundation

// MARK: - SyncState

public enum SyncState {
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
  public var debugDescription: String {
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
  public static func == (_ lhs: SyncState, _ rhs: SyncState) -> Bool {
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
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self)
  }
}
