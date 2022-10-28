//
//  ContentViewModel.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-12.
//

import Foundation
import ToDoShared
import ToDoStore
import ToDoDatabase
import Combine

extension ContentView {
  class ViewModel: ObservableObject {

    // MARK: - Properties

    private let auth: AuthEngine

    @Published var isLoggedIn: Bool = false

    var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(authEngine: AuthEngine = FirebaseAuthEngine.shared) {
      self.auth = authEngine

      self.auth.isLoggedIn
        .sink { [weak self] isLoggedIn in
          self?.isLoggedIn = isLoggedIn
        }
        .store(in: &cancellables)
    }

  }
}
