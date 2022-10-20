//
//  TodoListViewModel.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-04.
//

import Foundation
import Combine
import ToDoStore

extension TodoListView {
  class ViewModel: ObservableObject {

    // MARK: - Properties

    //  @Published var isAddingTodo: Bool = false

    //  var todos = store.subscribe {
    //    print("**** State change:\n\($0.todoState)")
    //    return $0.todoState.items
    //  }

    //  private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    //  init() {
    //    todos.objectDidChange
    //      .sink { value in
    //        print("**** Old State:\n\(value.old)")
    //        print("**** New State:\n\(value.new)")
    //      }
    //      .store(in: &cancellables)
    //  }

    // MARK: - Functions

    func deleteTodo(at offsets: IndexSet) {
      for index in offsets {
        let deleteTodo = store.state.todoState.items[index]
        store.dispatch(deleteFromDatabase(todo: deleteTodo))
      }
    }

    //  func openAddTodo() {
    //    isAddingTodo = true
    //  }
  }
}
