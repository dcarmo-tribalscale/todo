//
//  SignUpView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-12.
//

import SwiftUI

struct SignUpView: View {

  // MARK: - Properties

  @Environment(\.presentationMode) var presentationMode

  @StateObject var viewModel = SignUpView.ViewModel()

  // MARK: - Body

  var body: some View {
    VStack(spacing: 14) {

      HStack {
        Spacer()

        Button {
          presentationMode.wrappedValue.dismiss()
        } label: {
          Image(systemSymbol: .xmark)
        }
      }

      Spacer()

      Text(LocalizedStrings.User.SignUp.title)
        .font(.title)
        .fontWeight(.bold)

      InputFieldView(title: LocalizedStrings.User.SignUp.email,
                     placeholder: LocalizedStrings.User.SignUp.email,
                     error: $viewModel.emailError,
                     value: $viewModel.email)

      InputFieldView(title: LocalizedStrings.User.SignUp.password,
                     placeholder: LocalizedStrings.User.SignUp.password,
                     error: $viewModel.passwordError,
                     value: $viewModel.password)

      InputFieldView(title: LocalizedStrings.User.SignUp.confirmPassword,
                     placeholder: LocalizedStrings.User.SignUp.confirmPassword,
                     error: $viewModel.confirmPasswordError,
                     value: $viewModel.confirmPassword)
      .padding(.bottom, 10)

      Button {
        viewModel.signUp()
      } label: {
        Text(LocalizedStrings.User.SignUp.signUp)
          .modifier(PrimaryButtonModifier())
      }

      Spacer()
    } //: VStack
    .padding()
  }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
