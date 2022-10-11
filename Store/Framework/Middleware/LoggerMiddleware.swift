//
//  LoggerMiddleware.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-06.
//

import Foundation
import ReSwift

let loggerMiddleware: Middleware<AppState> = { _, getState in
  return { next in
    return { action in
      print("\n===State Update Start===")

      let currentState = getState()
      print("Current State:\n\(String(describing: currentState))")
      print("\nApplying Action:\n\(action)")

      next(action)

      let nextState = getState()
      print("\nNext State:\n\(String(describing: nextState))")
      print("===State Update End===\n")
    }
  }
}
