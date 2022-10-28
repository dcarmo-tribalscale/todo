//
//  SettingsView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-12.
//

import SwiftUI
import ToDoDatabase

struct SettingsView: View {

  // MARK: - Properties

  private let auth: AuthEngine = FirebaseAuthEngine.shared

  // MARK: - Body

  var body: some View {
    NavigationView {
      VStack {
        Spacer()

        Button {
          do {
            try auth.signOut()
          } catch {
            print(error)
          }
        } label: {
          Text(LocalizedStrings.Settings.SignOut.title)
            .modifier(PrimaryButtonModifier())
        }
        .padding()
      }
      .navigationTitle(LocalizedStrings.Settings.Nav.title)
    }
  }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
