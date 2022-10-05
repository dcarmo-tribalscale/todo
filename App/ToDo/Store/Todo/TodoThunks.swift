//
//  TodoThunks.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-05.
//

import Foundation
import ReSwiftThunk
import ToDoDatabase
import ToDoShared

let fetchTodos = Thunk<AppState> { dispatch, _ in
  Task.detached {
    let firebaseDBEngine = FirebaseDBEngine()

    do {
      if let todos = try await firebaseDBEngine.getTodos() as? [Todo] {
        dispatch(TodoAction.save(todos: todos))
      }
    } catch {
      print(error)
    }
  }
}

func saveToDatabase(todo: Todo) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, _ in
    Task.detached {
      let firebaseDBEngine = FirebaseDBEngine()

      do {
        try await firebaseDBEngine.saveTodo(todo: todo)
        dispatch(TodoAction.create(todo: todo))
      } catch {
        print(error)
      }
    }
  }
}
