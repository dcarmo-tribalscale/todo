//
//  SignUpViewModel.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-12.
//

import Foundation
import Combine
import ToDoAuth

extension SignUpView {
  @MainActor
  class ViewModel: ObservableObject {

    // MARK: - Properties

    @Published var email: String = ""
    @Published var emailError: String = ""

    @Published var password: String = ""
    @Published var passwordError: String = ""

    @Published var confirmPassword: String = ""
    @Published var confirmPasswordError: String = ""

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

      $confirmPassword
        .sink { [weak self] value in
          if !value.isEmpty {
            self?.confirmPasswordError = ""
          }
        }
        .store(in: &cancellables)
    }

    // MARK: - Functions

    func signUp() {
      if email.isEmpty {
        emailError = LocalizedStrings.User.SignUp.Email.Error.empty
      }

      if password.isEmpty {
        passwordError = LocalizedStrings.User.SignUp.Password.Error.empty
      }

      if confirmPassword.isEmpty {
        confirmPasswordError = LocalizedStrings.User.SignUp.ConfirmPassword.Error.empty
      } else if password != confirmPassword {
        confirmPasswordError = LocalizedStrings.User.SignUp.ConfirmPassword.Error.empty
      }

      if emailError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty {
        Task { [weak self] in
          guard let self else { return }

          do {
            try await self.auth.signUp(email: self.email, password: self.password)
          } catch {
            print(error)
          }
        }
      }
    }
  }
}
