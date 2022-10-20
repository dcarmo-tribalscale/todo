// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum LocalizedStrings {
  internal enum Settings {
    internal enum Nav {
      /// Settings
      internal static let title = LocalizedStrings.tr("Localizable", "settings.nav.title", fallback: "Settings")
    }
    internal enum SignOut {
      /// Sign Out
      internal static let title = LocalizedStrings.tr("Localizable", "settings.sign_out.title", fallback: "Sign Out")
    }
  }
  internal enum Tabbar {
    internal enum Settings {
      /// Settings
      internal static let title = LocalizedStrings.tr("Localizable", "tabbar.settings.title", fallback: "Settings")
    }
    internal enum Todos {
      /// Localizable.strings
      ///   ToDo
      /// 
      ///   Created by TribalScale on 2022-10-03.
      internal static let title = LocalizedStrings.tr("Localizable", "tabbar.todos.title", fallback: "Todos")
    }
  }
  internal enum TodoAdd {
    internal enum Button {
      /// Save
      internal static let save = LocalizedStrings.tr("Localizable", "todo_add.button.save", fallback: "Save")
    }
    internal enum Input {
      /// Description
      internal static let description = LocalizedStrings.tr("Localizable", "todo_add.input.description", fallback: "Description")
      /// Due Date
      internal static let dueDate = LocalizedStrings.tr("Localizable", "todo_add.input.due_date", fallback: "Due Date")
      /// Title
      internal static let title = LocalizedStrings.tr("Localizable", "todo_add.input.title", fallback: "Title")
    }
    internal enum Nav {
      /// Title
      internal static let title = LocalizedStrings.tr("Localizable", "todo_add.nav.title", fallback: "Title")
    }
  }
  internal enum TodoList {
    /// There's nothing Todo! Use the plus to add a new Todo.
    internal static let empty = LocalizedStrings.tr("Localizable", "todo_list.empty", fallback: "There's nothing Todo! Use the plus to add a new Todo.")
    internal enum Nav {
      /// Todos
      internal static let title = LocalizedStrings.tr("Localizable", "todo_list.nav.title", fallback: "Todos")
    }
  }
  internal enum User {
    internal enum SignIn {
      /// Email
      internal static let email = LocalizedStrings.tr("Localizable", "user.sign_in.email", fallback: "Email")
      /// Password
      internal static let password = LocalizedStrings.tr("Localizable", "user.sign_in.password", fallback: "Password")
      /// Sign In
      internal static let signIn = LocalizedStrings.tr("Localizable", "user.sign_in.sign_in", fallback: "Sign In")
      /// Sign Up
      internal static let signUp = LocalizedStrings.tr("Localizable", "user.sign_in.sign_up", fallback: "Sign Up")
      /// Sign In
      internal static let title = LocalizedStrings.tr("Localizable", "user.sign_in.title", fallback: "Sign In")
      internal enum Email {
        internal enum Error {
          /// You must provide an email.
          internal static let empty = LocalizedStrings.tr("Localizable", "user.sign_in.email.error.empty", fallback: "You must provide an email.")
        }
      }
      internal enum Password {
        internal enum Error {
          /// You must provide a password.
          internal static let empty = LocalizedStrings.tr("Localizable", "user.sign_in.password.error.empty", fallback: "You must provide a password.")
        }
      }
    }
    internal enum SignUp {
      /// Confirm Password
      internal static let confirmPassword = LocalizedStrings.tr("Localizable", "user.sign_up.confirm_password", fallback: "Confirm Password")
      /// Email
      internal static let email = LocalizedStrings.tr("Localizable", "user.sign_up.email", fallback: "Email")
      /// Password
      internal static let password = LocalizedStrings.tr("Localizable", "user.sign_up.password", fallback: "Password")
      /// Sign Up
      internal static let signUp = LocalizedStrings.tr("Localizable", "user.sign_up.sign_up", fallback: "Sign Up")
      /// Sign Up
      internal static let title = LocalizedStrings.tr("Localizable", "user.sign_up.title", fallback: "Sign Up")
      internal enum ConfirmPassword {
        internal enum Error {
          /// You must confirm your password.
          internal static let empty = LocalizedStrings.tr("Localizable", "user.sign_up.confirm_password.error.empty", fallback: "You must confirm your password.")
          /// Your password confirmation must match the above password.
          internal static let missmatch = LocalizedStrings.tr("Localizable", "user.sign_up.confirm_password.error.missmatch", fallback: "Your password confirmation must match the above password.")
        }
      }
      internal enum Email {
        internal enum Error {
          /// You must provide an email.
          internal static let empty = LocalizedStrings.tr("Localizable", "user.sign_up.email.error.empty", fallback: "You must provide an email.")
        }
      }
      internal enum Password {
        internal enum Error {
          /// You must provide a password.
          internal static let empty = LocalizedStrings.tr("Localizable", "user.sign_up.password.error.empty", fallback: "You must provide a password.")
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension LocalizedStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
