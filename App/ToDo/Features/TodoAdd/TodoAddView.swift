//
//  TodoAddView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-04.
//

import SwiftUI

struct TodoAddView: View {

  // MARK: - Properties

  @Environment(\.presentationMode) private var presentationMode

  @ObservedObject var viewModel = TodoAddView.ViewModel()

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: 14) {
      InputFieldView(title: LocalizedStrings.TodoAdd.Input.title,
                     placeholder: LocalizedStrings.TodoAdd.Input.title,
                     error: $viewModel.titleError,
                     value: $viewModel.title)

      InputFieldView(title: LocalizedStrings.TodoAdd.Input.description,
                     placeholder: LocalizedStrings.TodoAdd.Input.description,
                     error: $viewModel.descriptionError,
                     value: $viewModel.description)

      VStack {
        Button {
          if viewModel.saveTodo() {
            presentationMode.wrappedValue.dismiss()
          }
        } label: {
          Text(LocalizedStrings.TodoAdd.Button.save)
            .modifier(PrimaryButtonModifier())
        }

#if DEBUG
        Button {
          if viewModel.saveTodo(delay: 4) {
            presentationMode.wrappedValue.dismiss()
          }
        } label: {
          Text("Save Delayed")
            .modifier(PrimaryButtonModifier())
        }
#endif
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
    TodoAddView()
  }
}
