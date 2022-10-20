//
//  SignInView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-11.
//

import SwiftUI

struct SignInView: View {

  // MARK: - Properties

  @StateObject var viewModel = SignInView.ViewModel()

  // MARK: - Body

  var body: some View {
    VStack(spacing: 14) {

      Spacer()

      Text(LocalizedStrings.User.SignIn.title)
        .font(.title)
        .fontWeight(.bold)

      InputFieldView(title: LocalizedStrings.User.SignIn.email,
                     placeholder: LocalizedStrings.User.SignIn.email,
                     error: $viewModel.emailError,
                     value: $viewModel.email)

      InputFieldView(title: LocalizedStrings.User.SignIn.password,
                     placeholder: LocalizedStrings.User.SignIn.password,
                     error: $viewModel.passwordError,
                     value: $viewModel.password)
      .padding(.bottom, 10)

      ZStack {
        Button {
          viewModel.signIn()
        } label: {
          Text(LocalizedStrings.User.SignIn.signIn)
            .modifier(PrimaryButtonModifier(isDisabled: self.viewModel.isSigningIn))
        }

        if self.viewModel.isSigningIn {
          ProgressView()
        }
      }

      Spacer()

      Button {
        viewModel.isSigningUp = true
      } label: {
        Text(LocalizedStrings.User.SignIn.signUp)
          .modifier(PrimaryButtonModifier())
      }
    } //: VStack
    .padding()
    .sheet(isPresented: $viewModel.isSigningUp) {
      SignUpView()
    }
  }
}

// MARK: - Preview

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}
