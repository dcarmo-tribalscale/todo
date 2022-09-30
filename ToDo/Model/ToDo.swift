//
//  ToDo.swift
//  ToDo
//
//  Created by TribalScale on 2022-09-30.
//

import Foundation

struct ToDo {
  let id: UUID = .init()
  let title: String
  let complete: Bool
}

extension ToDo: Identifiable { }

extension ToDo: Equatable {
  static func == (_ lhs: ToDo, _ rhs: ToDo) -> Bool {
    if lhs.id == rhs.id && lhs.title == rhs.title && lhs.complete == rhs.complete {
      return true
    } else {
      return false
    }
  }
}

extension ToDo: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
