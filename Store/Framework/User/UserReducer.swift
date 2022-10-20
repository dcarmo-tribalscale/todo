//
//  Reducer.swift
//  ToDoStore
//
//  Created by TribalScale on 2022-10-12.
//

import Foundation

extension UserState {
  static func reducer(action: UserAction, state: UserState?) -> UserState {
    let state = state ?? UserState()

    return state
  }
}
