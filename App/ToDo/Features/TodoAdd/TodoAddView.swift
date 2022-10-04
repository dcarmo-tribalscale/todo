//
//  TodoAddView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-04.
//

import SwiftUI

struct TodoAddView: View {

  // MARK: - Properties

  @ObservedObject private var viewModel = TodoAddViewModel()

  @Binding var isAddingTodo: Bool

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: 14) {

      Spacer()

      TextField(LocalizedStrings.TodoAdd.Input.title, text: $viewModel.title)
        .padding()
        .background(Color(UIColor.tertiarySystemFill))
        .cornerRadius(9)
        .font(.system(size: 24, weight: .bold, design: .default))

      TextField(LocalizedStrings.TodoAdd.Input.description, text: $viewModel.description)
        .padding()
        .background(Color(UIColor.tertiarySystemFill))
        .cornerRadius(9)
        .font(.system(size: 24, weight: .bold, design: .default))

      Button {
        viewModel.saveTodo()

        withAnimation(.easeIn) {
          isAddingTodo = false
        }
      } label: {
        Text(LocalizedStrings.TodoAdd.Button.save)
            .font(.system(size: 24, weight: .bold, design: .default))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
              RoundedRectangle(cornerRadius: 9)
                .fill(.blue)
            )
            .foregroundColor(.white)
      }

      Spacer()
    }
    .padding()
    .navigationBarTitle(LocalizedStrings.TodoAdd.Nav.title)
  }
}

// MARK: - Preview

struct TodoAddView_Previews: PreviewProvider {
  static var previews: some View {
    TodoAddView(isAddingTodo: .constant(true))
  }
}
