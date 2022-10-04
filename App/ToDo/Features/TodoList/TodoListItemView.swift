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

  // MARK: - Body

  var body: some View {
    HStack(alignment: .center) {
      Image(systemSymbol: todo.complete ? .checkmarkSquareFill : .square)
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(.blue)
        .onTapGesture {
          print("Complete Task")
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
    }
  }
}

// MARK: - Preview

struct TodoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItemView(todo: todoStandard)
          .previewDisplayName("Standard")
          .previewLayout(.sizeThatFits)
          .padding()

        TodoListItemView(todo: todoLongDescription)
          .previewDisplayName("Long Description")
          .previewLayout(.sizeThatFits)
          .padding()

        TodoListItemView(todo: todoLongTitle)
          .previewDisplayName("Long Title")
          .previewLayout(.sizeThatFits)
          .padding()
    }
}
