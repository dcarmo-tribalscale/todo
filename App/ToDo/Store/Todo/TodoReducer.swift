//
//  Reducer.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift

extension TodoState {
  static func reducer(action: Action, state: TodoState?) -> TodoState {
    var state = state ?? TodoState(items: [], itemsSyncState: [:])

    guard let todoAction = action as? TodoAction else { return state }

    switch todoAction {
    case let .create(todo):
      // Todo already added but failed to sync potentially
      if state.items.firstIndex(where: { $0.id == todo.id }) == nil {
        state.items.append(todo)
      }

    case let .delete(id):
      state.items = state.items.filter { $0.id != id }

    case let .save(todos):
      state.items = todos

    case let .update(todo):
      if let index = state.items.firstIndex(of: todo) {
        state.items[index] = todo
      }

    case let .updateComplete(todo):
      if let todoIndex = state.items.firstIndex(where: { $0.id == todo.id }) {
        state.items[todoIndex] = todo
      }

    case let .updateSyncState(id, syncState):
      state.itemsSyncState[id] = syncState

    case let .removeSyncState(id):
      state.itemsSyncState.removeValue(forKey: id)

    }
    return state
  }
}
