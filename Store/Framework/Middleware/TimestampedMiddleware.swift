//
//  TimestampedMiddleware.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-06.
//

import Foundation
import ReSwift

// MARK: - Timestamped Action

protocol TimestampedAction: Action {
  func timestampUpdatedAction() -> Self
}

// MARK: - timestampedMiddleware

let timestampedMiddleware: Middleware<AppState> = { _, _ in
  return { next in
    return { action in
      guard let timestampedAction = action as? TimestampedAction else {
        next(action)
        return
      }

      next(timestampedAction.timestampUpdatedAction())
    }
  }
}
