//
//  AppState.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift

// MARK: - State

public struct AppState {
  public let todoState: TodoState
}

// MARK: - CustomDebugStringConvertible

extension AppState: CustomDebugStringConvertible {
  public var debugDescription: String {
    return """
State: {
  todoState: \(todoState.debugDescription)
}
"""
  }
}
