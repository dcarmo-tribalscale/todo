//
//  ContentView.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import SFSafeSymbols
import SwiftUI
import ReSwift

struct ContentView: View {

  // MARK: - Body

  var body: some View {
    NavigationView {
      TodoListView()
        .navigationTitle(LocalizedStrings.TodoList.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
          }

          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              print("Add Item")
            } label: {
              Image(systemSymbol: .plus)
            }
          }
        }
    }
  }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {

  static var previews: some View {
    ContentView()
      .onAppear {
        for todo in sampleTodos {
          store.dispatch(TodoAction.create(todo: todo))
        }
      }
  }
}
