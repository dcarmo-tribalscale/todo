//
//  TodoListView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import SwiftUI

struct TodoListView: View {

  // MARK: - Properties

  @StateObject var todos = store.subscribe { $0.todoState.items }

  // MARK: - Functions

  private func deleteTodo(at offsets: IndexSet) {
      for index in offsets {
        let deleteTodo = todos.current[index]
        store.dispatch(TodoAction.delete(id: deleteTodo.id))
      }
  }

  // MARK: - Body

  var body: some View {
    List {
      ForEach(todos.current) { todo in
        TodoListItemView(todo: todo)
      }
      .onDelete(perform: deleteTodo)
    }
  }
}

// MARK: - Preview

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView(todos: .init { _ in sampleTodos })
  }
}
