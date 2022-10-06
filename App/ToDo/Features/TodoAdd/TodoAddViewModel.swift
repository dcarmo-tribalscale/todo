//
//  TodoAddViewModel.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-04.
//

import Foundation
import ToDoShared

class TodoAddViewModel: ObservableObject {

  // MARK: - Properties

  @Published var title: String = ""
  @Published var description: String = ""

  @Published var titleError: String = ""
  @Published var descriptionError: String = ""

  // MARK: - Lifecycle

  // MARK: - Functions

  func saveTodo(delay: CGFloat = 0) -> Bool {
    guard !title.isEmpty else {
      titleError = "Title cannot be empty"
      return false
    }

    guard !description.isEmpty else {
      descriptionError = "Description cannot be empty"
      return false
    }

    let newTodo = Todo(title: title, description: description, complete: false)
    store.dispatch(saveToDatabase(todo: newTodo, testingDelay: delay))
    return true
  }

}
