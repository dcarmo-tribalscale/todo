//
//  ContentView.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import SFSafeSymbols
import SwiftUI
import ToDoShared
import ToDoStore
import ToDoDatabase

struct ContentView: View {

  // MARK: - Properties

  @ObservedObject private var viewModel = ContentView.ViewModel()

  // MARK: - Body

  var body: some View {
    ZStack {
      if viewModel.isLoggedIn {
        TabView {
          NavigationView {
            TodoListView()
          }
          .tabItem {
            Label(LocalizedStrings.Tabbar.Todos.title, systemSymbol: .listBullet)
          }

          SettingsView()
            .tabItem {
              Label(LocalizedStrings.Tabbar.Settings.title, systemSymbol: .gear)
            }
        }
      } else {
        SignInView()
      }
    }
    .transition(.opacity)
    .animation(.easeIn(duration: 0.33), value: viewModel.isLoggedIn)
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
