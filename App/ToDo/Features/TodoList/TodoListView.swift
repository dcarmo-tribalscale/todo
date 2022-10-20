//
//  TodoListView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import SwiftUI
import ToDoShared
import ToDoStore

struct TodoListView: View {

  // MARK: - Properties

  @Environment(\.scenePhase) var scenePhase

  @StateObject var viewModel = TodoListView.ViewModel()

  @StateObject var todos = store.subscribe { $0.todoState.items }
  @StateObject var todosSyncState = store.subscribe { $0.todoState.itemsSyncState }

  @State var isAddingTodo: Bool = false

  // MARK: - Functions

  // MARK: - Body

  var body: some View {
    ZStack {
      if todos.current.isEmpty {
        Text(LocalizedStrings.TodoList.empty)
          .font(.title3)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
          .padding()
      } else {
        List {
          ForEach(todos.current) { todo in
            TodoListItemView(todo: todo, syncState: todosSyncState.current[todo.id])
          } //: ForEach
          .onDelete(perform: viewModel.deleteTodo)
        } //: List
      }
    } //: ZStack
    .navigationTitle(LocalizedStrings.TodoList.Nav.title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        EditButton()
      }

      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          isAddingTodo = true
        } label: {
          Image(systemSymbol: .plus)
        }
      }
    }
    .sheet(isPresented: $isAddingTodo) {
      TodoAddView()
    }
    .onAppear {
      if todos.current.isEmpty {
        store.dispatch(fetchTodos())
      }
    }
    .onChange(of: scenePhase) { newValue in
      switch newValue {
      case .active:
        switch shortcutAction {
        case .addTodo:
          isAddingTodo = true
          shortcutAction = nil
        default:
          break
        }
      default:
        break
      }
    }
  }
}

// MARK: - Preview

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TodoListView()
        .previewDisplayName("Empty List")
    }

    NavigationView {
      TodoListView()
        .previewDisplayName("Populated List")
        .onAppear {
          for todo in sampleTodos {
            store.dispatch(TodoAction.create(todo: todo))
          }
        }
    }
  }
}
