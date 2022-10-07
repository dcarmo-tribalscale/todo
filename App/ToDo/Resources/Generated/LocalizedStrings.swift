// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum LocalizedStrings {
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
      /// Localizable.strings
      ///   ToDo
      /// 
      ///   Created by TribalScale on 2022-10-03.
      internal static let title = LocalizedStrings.tr("Localizable", "todo_list.nav.title", fallback: "Todos")
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
