//
//  AppState.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift

// MARK: - State

struct AppState {
  let todoState: TodoState
}

// MARK: - CustomDebugStringConvertible

extension AppState: CustomDebugStringConvertible {
  var debugDescription: String {
    return """
State: {
  todoState: \(todoState.debugDescription)
}
"""
  }
}
