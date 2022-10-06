//
//  TodoListItemView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import SwiftUI
import ToDoShared

struct TodoListItemView: View {

  // MARK: - Properties

  let todo: Todo
  let syncState: SyncState?

  // MARK: - Body

  var body: some View {
    HStack(alignment: .center) {
      Image(systemSymbol: todo.complete ? .checkmarkSquareFill : .square)
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(.blue)
        .disabled(syncState != nil)
        .onTapGesture {
          store.dispatch(toggleComplete(on: todo))
        }

      VStack(alignment: .leading, spacing: 6) {
        Text(todo.title)
          .font(.subheadline)
          .fontWeight(.bold)
          .multilineTextAlignment(.leading)

        Text(todo.description)
          .font(.footnote)
          .foregroundColor(.gray)
          .lineLimit(4)
          .multilineTextAlignment(.leading)
      }

      Spacer()

      SyncStateView(state: syncState)
    }
  }
}

// MARK: - Preview

struct TodoListItemView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        TodoListItemView(todo: todoStandard, syncState: nil)
          .previewDisplayName("Standard")
          .previewLayout(.sizeThatFits)
          .padding()

        TodoListItemView(todo: todoLongDescription, syncState: nil)
          .previewDisplayName("Long Description")
          .previewLayout(.sizeThatFits)
          .padding()

        TodoListItemView(todo: todoLongTitle, syncState: nil)
          .previewDisplayName("Long Title")
          .previewLayout(.sizeThatFits)
          .padding()
      }
    }
}
