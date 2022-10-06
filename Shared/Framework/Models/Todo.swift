//
//  Todo.swift
//  Todo
//
//  Created by TribalScale on 2022-09-30.
//

import Foundation

// MARK: - Todo Struct

public struct Todo {

  // MARK: - Properties

  public let id: String
  public let title: String
  public let description: String
  public var complete: Bool

  // MARK: - Timestamped Properties

  public var createdAt: TimeInterval
  public var updatedAt: TimeInterval

  // MARK: - Lifecycle

  public init(id: String = UUID.init().uuidString,
              title: String,
              description: String,
              complete: Bool,
              createdAt: TimeInterval = Date().timeIntervalSince1970,
              updatedAt: TimeInterval = Date().timeIntervalSince1970) {

    self.id = id
    self.title = title
    self.description = description
    self.complete = complete
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }
}

// MARK: - CustomDebugStringConvertible

extension Todo: CustomDebugStringConvertible {
  public var debugDescription: String {
"""
Todo: {
  id: \(id)
  title: \(title)
  description: \(description)
  complete: \(complete ? "YES" : "NO")
  createdAt: \(createdAt)
  updatedAt: \(updatedAt)
}
"""
  }
}

// MARK: - Timestamped

extension Todo: Timestamped { }

// MARK: - Identifiable

extension Todo: Identifiable { }

// MARK: - Codable

extension Todo: Codable { }

// MARK: - Equatable

extension Todo: Equatable {
  public static func == (_ lhs: Todo, _ rhs: Todo) -> Bool {
    return lhs.id == rhs.id
    && lhs.title == rhs.title
    && lhs.description == rhs.description
    && lhs.complete == rhs.complete
  }
}

// MARK: - Hashable

extension Todo: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

// MARK: - Sample Data

#if DEBUG
public let todoStandard = Todo(
  title: "ToDo 1",
  description: "This is a description for ToDo 1",
  complete: false
)

public let todoLongDescription = Todo(
  title: "ToDo 2",
  // swiftlint:disable:next line_length
  description: "This is a description for ToDo 2 that is really long and should wrap when it gets big and allow you to put as much text as you want there.",
  complete: true
)

public let todoLongTitle = Todo(
  title: "ToDo 3 - With a really long title to see that it keep going and wrap the text",
  description: "This is a description for ToDo 3",
  complete: true
)

public let sampleTodos = [
  todoStandard,
  todoLongDescription,
  todoLongTitle
]
#endif
