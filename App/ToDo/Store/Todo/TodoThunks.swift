//
//  TodoThunks.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-05.
//

import Foundation
import ReSwift
import ReSwiftThunk
import ToDoDatabase
import ToDoShared

func fetchTodos(dbEngine: DBEngine = FirebaseDBEngine()) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, _ in
    Task.detached {
      do {
        let todos = try await dbEngine.getTodos()
        dispatch(TodoAction.save(todos: todos))
      } catch {
        print(error)
      }
    }
  }
}

func saveToDatabase(todo: Todo, dbEngine: DBEngine = FirebaseDBEngine(), testingDelay: CGFloat = 0) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, _ in
    Task.detached {
      // Create the todo locally
      dispatch(TodoAction.create(todo: todo))

      await syncStateManagedCall(dispatch: dispatch, todoId: todo.id) {
        // Testing with delay to see spinner on screen
        DispatchQueue.global().asyncAfter(deadline: .now() + testingDelay) {
          Task.detached {
            // sync the todo to Firebase
            try await dbEngine.save(todo: todo)
          }
        }

      }
    }
  }
}

func deleteFromDatabase(todo: Todo, dbEngine: DBEngine = FirebaseDBEngine()) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, _ in
    Task.detached {
      do {
        // sync the todo to Firebase
        try await dbEngine.delete(todo: todo)
        dispatch(TodoAction.delete(id: todo.id))
      } catch {
        print(error)
      }
    }
  }
}

func toggleCompleted(todo: Todo, dbEngine: DBEngine = FirebaseDBEngine()) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, _ in
    Task.detached {
      await syncStateManagedCall(dispatch: dispatch, todoId: todo.id) {
        // sync the todo to Firebase
        try await dbEngine.updateCompleted(todoId: todo.id, complete: !todo.complete)
        dispatch(TodoAction.updateComplete(id: todo.id, complete: !todo.complete))
      }
    }
  }
}

private func syncStateManagedCall(dispatch: @escaping DispatchFunction, todoId: Todo.ID, body: () async throws -> Void) async {
  do {
    // Set the state of the todo to syncing
    dispatch(TodoAction.updateSyncState(id: todoId, syncState: .syncing))

    // sync the todo to Firebase
    try await body()

    // Set the state of the todo to syncing
    dispatch(TodoAction.updateSyncState(id: todoId, syncState: .complete))

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      dispatch(TodoAction.removeSyncState(id: todoId))
    }
  } catch {
    print(error)
    // Set the state of the todo to syncing
    dispatch(TodoAction.updateSyncState(id: todoId, syncState: .failed))
  }
}
