//
//  ContentView.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import SFSafeSymbols
import SwiftUI
import ReSwift
import ToDoShared

struct ContentView: View {

  // MARK: - Body

  var body: some View {
    NavigationView {
      TodoListView()
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
