//
//  TodoListViewModel.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-04.
//

import Foundation

class TodoListViewModel: ObservableObject {

  // MARK: - Properties

  @Published var todos = store.subscribe {
    print("**** State change:\n\n\($0.todoState)")
    return $0.todoState.items
  }

  // MARK: - Lifecycle

  // MARK: - Functions

  func deleteTodo(at offsets: IndexSet) {
      for index in offsets {
        let deleteTodo = todos.current[index]
        store.dispatch(TodoAction.delete(id: deleteTodo.id))
      }
  }
}
