//
//  TodoListView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import SwiftUI
import ToDoShared

struct TodoListView: View {

  // MARK: - Properties

  let addViewHeight: CGFloat = 300
  let addViewShadowRadius: CGFloat = 2
  let notchPadding: CGFloat = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)

  @State var isAddingTodo: Bool = false

  @ObservedObject var viewModel: TodoListViewModel

  // MARK: - Body

  var body: some View {
    ZStack {
      if viewModel.todos.current.isEmpty {
        Text(LocalizedStrings.TodoList.empty)
          .font(.title3)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
          .padding()
      } else {
        List {
          ForEach(viewModel.todos.current) { todo in
            TodoListItemView(todo: todo)
          } //: ForEach
          .onDelete(perform: viewModel.deleteTodo)
        } //: List
      }

      VStack {
        Spacer()

        TodoAddView(isAddingTodo: $isAddingTodo)
          .frame(height: addViewHeight, alignment: .bottom)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(.white)
              .shadow(color: .black.opacity(0.2), radius: addViewShadowRadius, x: 0, y: -4)
          )
          .offset(y: isAddingTodo ? 0 : (addViewHeight + addViewShadowRadius + notchPadding))
      } //: VStack
    } //: ZStack
    .navigationTitle(LocalizedStrings.TodoList.Nav.title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        EditButton()
      }

      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          withAnimation(.easeOut) {
            isAddingTodo = true
          }
        } label: {
          Image(systemSymbol: .plus)
        }
      }
    }
  }
}

// MARK: - Preview

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TodoListView(viewModel: TodoListViewModel())
        .previewDisplayName("Empty List")
    }

    NavigationView {
      TodoListView(viewModel: TodoListViewModel())
        .previewDisplayName("Populated List")
        .onAppear {
          for todo in sampleTodos {
            store.dispatch(TodoAction.create(todo: todo))
          }
        }
    }
  }
}
