//
//  Timestamped.swift
//  ToDoShared
//
//  Created by TribalScale on 2022-10-06.
//

import Foundation

// MARK: - Timestamped

public protocol Timestamped {
  var createdAt: TimeInterval { get }
  var updatedAt: TimeInterval { get set }
}

// MARK: - Timestamped extension

public extension Timestamped {
  var createdAtDate: Date {
    Date(timeIntervalSince1970: createdAt)
  }

  var updatedAtDate: Date {
    Date(timeIntervalSince1970: createdAt)
  }
}
