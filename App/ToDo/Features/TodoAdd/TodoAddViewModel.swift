//
//  TodoAddViewModel.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-04.
//

import Combine
import Foundation
import ToDoShared

class TodoAddViewModel: ObservableObject {

  // MARK: - Properties

  @Published var title: String = ""
  @Published var description: String = ""

  @Published var titleError: String = ""
  @Published var descriptionError: String = ""

  private var cancellables = Set<AnyCancellable>()

  // MARK: - Lifecycle

  init() {
    $title
      .sink { [weak self] value in
        if !value.isEmpty {
          self?.titleError = ""
        }
      }
      .store(in: &cancellables)

    $description
      .sink { [weak self] value in
        if !value.isEmpty {
          self?.descriptionError = ""
        }
      }
      .store(in: &cancellables)
  }

  // MARK: - Functions

  func saveTodo(delay: UInt64? = nil) -> Bool {
    if title.isEmpty {
      titleError = "Title cannot be empty"
    } else {
      titleError = ""
    }

    if description.isEmpty {
      descriptionError = "Description cannot be empty"
    } else {
      descriptionError = ""
    }

    if titleError.isEmpty && descriptionError.isEmpty {
      let newTodo = Todo(title: title, description: description, complete: false)
      store.dispatch(saveToDatabase(todo: newTodo, testingDelay: delay))
      return true
    }

    return false
  }
}
