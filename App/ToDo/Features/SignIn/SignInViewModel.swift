//
//  SignInViewModel.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-12.
//

import Foundation
import Combine
import ToDoDatabase

extension SignInView {
  @MainActor
  class ViewModel: ObservableObject {

    // MARK: - Properties

    @Published var email: String = ""
    @Published var emailError: String = ""

    @Published var password: String = ""
    @Published var passwordError: String = ""

    @Published var isSigningUp: Bool = false

    @Published var isSigningIn: Bool = false

    private var auth: AuthEngine

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(authEngine: AuthEngine = FirebaseAuthEngine.shared) {
      self.auth = authEngine

      $email
        .sink { [weak self] value in
          if !value.isEmpty {
            self?.emailError = ""
          }
        }
        .store(in: &cancellables)

      $password
        .sink { [weak self] value in
          if !value.isEmpty {
            self?.passwordError = ""
          }
        }
        .store(in: &cancellables)
    }

    // MARK: - Functions

    func signIn() {
      if email.isEmpty {
        emailError = LocalizedStrings.User.SignIn.Email.Error.empty
      }

      if password.isEmpty {
        passwordError = LocalizedStrings.User.SignIn.Password.Error.empty
      }

      if emailError.isEmpty && passwordError.isEmpty {
        self.isSigningIn = true

        Task { [weak self] in
          guard let self else { return }

          do {
            try await self.auth.signIn(email: self.email, password: self.password)
          } catch {
            print(error)
            self.isSigningIn = false
          }
        }
      }
    }
  }
}
