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
    // Create the todo locally
    dispatch(TodoAction.create(todo: todo))
    // Set the state of the todo to syncing
    dispatch(TodoAction.updateSyncState(todo: todo, syncState: .syncing))

    // Testing with delay to see spinner on screen
    DispatchQueue.global().asyncAfter(deadline: .now() + testingDelay) {
      Task.detached {
        do {
          // sync the todo to Firebase
          try await dbEngine.save(todo: todo)

          // Update the sync state to complete
          dispatch(TodoAction.updateSyncState(todo: todo, syncState: .complete))

          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            dispatch(TodoAction.removeSyncState(todo: todo))
          }
        } catch {
          print(error)
          // Error occured, notify
          dispatch(TodoAction.updateSyncState(todo: todo, syncState: .failed))
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
        // Error occured, notify
        dispatch(TodoAction.updateSyncState(todo: todo, syncState: .failed))
      }
    }
  }
}
