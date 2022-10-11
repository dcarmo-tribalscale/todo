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
import WidgetKit

public func fetchTodos(dbEngine: DBEngine = FirebaseDBEngine()) -> Thunk<AppState> {
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

public func saveToDatabase(todo: Todo, dbEngine: DBEngine = FirebaseDBEngine(), testingDelay: UInt64? = nil) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, _ in
    Task.detached {
      // Create the todo locally
      dispatch(TodoAction.create(todo: todo))
      do {
        try await syncStateManagedCall(dispatch: dispatch, todoId: todo.id) {
//          throw NSError(domain: "com.dcarmo.Todo", code: 200)

          if let testingDelay {
            try await Task.sleep(nanoseconds: testingDelay * 1_000_000_000) // 1 second
          }

          // sync the todo to Firebase
          try await dbEngine.save(todo: todo)

          // Notify the widget of a change
          WidgetCenter.shared.reloadAllTimelines()
        }
      } catch {
        let retrySyncState: SyncState = .retry(block: {
          store.dispatch(saveToDatabase(todo: todo, dbEngine: dbEngine, testingDelay: testingDelay))
        })

        store.dispatch(TodoAction.updateSyncState(id: todo.id, syncState: retrySyncState))
      }
    }
  }
}

public func deleteFromDatabase(todo: Todo, dbEngine: DBEngine = FirebaseDBEngine()) -> Thunk<AppState> {
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

public func toggleComplete(on todo: Todo, dbEngine: DBEngine = FirebaseDBEngine()) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, _ in
    Task.detached {
      do {
        try await syncStateManagedCall(dispatch: dispatch, todoId: todo.id) {
          var updatedTodo = todo
          updatedTodo.complete = !updatedTodo.complete

//          throw NSError(domain: "com.dcarmo.Todo", code: 200)

          // sync the todo to Firebase
          try await dbEngine.updateComplete(on: updatedTodo)

          // Notify the widget of a change
          WidgetCenter.shared.reloadAllTimelines()

          dispatch(TodoAction.updateComplete(todo: updatedTodo))
        }
      } catch {
          let retrySyncState: SyncState = .retry(block: {
            store.dispatch(toggleComplete(on: todo, dbEngine: dbEngine))
          })

          store.dispatch(TodoAction.updateSyncState(id: todo.id, syncState: retrySyncState))
      }
    }
  }
}

private func syncStateManagedCall(dispatch: @escaping DispatchFunction, todoId: Todo.ID, body: () async throws -> Void) async throws {
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

    throw error
  }
}
