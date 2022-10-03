//
//  Todo.swift
//  Todo
//
//  Created by TribalScale on 2022-09-30.
//

import Foundation

#if DEBUG
let sampleTodos = [
  Todo(
    title: "ToDo 1",
    description: "This is a description for ToDo 1",
    complete: false
  ),
  Todo(
    title: "ToDo 2",
    // swiftlint:disable:next line_length
    description: "This is a description for ToDo 2 that is really long and should wrap when it gets big and allow you to put as much text as you want there.",
    complete: true
  ),
  Todo(
    title: "ToDo 3 - With a really long title to see that it keep going and wrap the text",
    description: "This is a description for ToDo 3",
    complete: true
  )
]
#endif

struct Todo {
  let id: UUID = .init()
  let title: String
  let description: String
  let complete: Bool
}

extension Todo: Identifiable { }

extension Todo: Equatable {
  static func == (_ lhs: Todo, _ rhs: Todo) -> Bool {
    if lhs.id == rhs.id && lhs.title == rhs.title && lhs.complete == rhs.complete {
      return true
    } else {
      return false
    }
  }
}

extension Todo: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
