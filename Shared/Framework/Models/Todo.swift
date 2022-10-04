//
//  Todo.swift
//  Todo
//
//  Created by TribalScale on 2022-09-30.
//

import Foundation

#if DEBUG

public let todoStandard = Todo(
  id: .init(),
  title: "ToDo 1",
  description: "This is a description for ToDo 1",
  complete: false
)

public let todoLongDescription = Todo(
  id: .init(),
  title: "ToDo 2",
  // swiftlint:disable:next line_length
  description: "This is a description for ToDo 2 that is really long and should wrap when it gets big and allow you to put as much text as you want there.",
  complete: true
)

public let todoLongTitle = Todo(
  id: .init(),
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

public struct Todo {
  public let id: UUID
  public let title: String
  public let description: String
  public let complete: Bool

  public init(id: UUID, title: String, description: String, complete: Bool) {
    self.id = id
    self.title = title
    self.description = description
    self.complete = complete
  }
}

extension Todo: Identifiable { }
extension Todo: Codable { }

extension Todo: Equatable {
  public static func == (_ lhs: Todo, _ rhs: Todo) -> Bool {
    if lhs.id == rhs.id && lhs.title == rhs.title && lhs.complete == rhs.complete {
      return true
    } else {
      return false
    }
  }
}

extension Todo: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
