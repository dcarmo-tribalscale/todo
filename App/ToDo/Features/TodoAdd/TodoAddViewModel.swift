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

  @Published var error: String = ""

  // MARK: - Lifecycle

  // MARK: - Functions

  func saveTodo() {
    guard !title.isEmpty else {
      return
    }

    guard !description.isEmpty else {
      return
    }

    store.dispatch(TodoAction.create(todo: Todo(id: .init(), title: title, description: description, complete: false)))
  }

}
