//
//  TodoListItemView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import SwiftUI

struct TodoListItemView: View {

  let todo: Todo

  var body: some View {
    HStack(alignment: .center) {
      Image(systemSymbol: todo.complete ? .checkmarkSquareFill : .square)
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(.blue)

      VStack(alignment: .leading) {
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

struct TodoListItemView_Previews: PreviewProvider {
    static var previews: some View {
      TodoListItemView(todo: sampleTodos[0])
        .previewLayout(.sizeThatFits)
        .padding()

      TodoListItemView(todo: sampleTodos[1])
        .previewLayout(.sizeThatFits)
        .padding()

      TodoListItemView(todo: sampleTodos[2])
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
