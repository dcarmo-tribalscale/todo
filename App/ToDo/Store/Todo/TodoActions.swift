//
//  Actions.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import Foundation
import ReSwift
import ReSwiftThunk

enum TodoAction: Action {
  case create(todo: Todo)
  case update(todo: Todo)
  case delete(id: Todo.ID)
  case save(todos: [Todo])
}

let fetchTodos = Thunk<AppState> { dispatch, getState in
  
}
