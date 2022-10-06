//
//  Reducer.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift

func todoReducer(action: Action, state: TodoState?) -> TodoState {
  var state = state ?? TodoState(items: [], itemsSyncState: [:])

  guard let todoAction = action as? TodoAction else { return state }

  switch todoAction {
  case let .create(todo):
    state.items.append(todo)
  case let .delete(id):
    state.items = state.items.filter { $0.id != id }
  case let .save(todos):
    state.items = todos
  case let .update(todo):
    if let index = state.items.firstIndex(of: todo) {
      state.items[index] = todo
    }
  case let .updateSyncState(todo, syncState):
    state.itemsSyncState[todo] = syncState
  case let .removeSyncState(todo):
    state.itemsSyncState.removeValue(forKey: todo)
  }
  return state
}
