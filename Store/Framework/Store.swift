//
//  Store.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift

// Middleware operates in a FIFO order before calling reducer
// and then in LIFO order after calling reducer
let middlewares = [
  timestampedMiddleware,
  loggerMiddleware,
  thunkMiddleware
]

public var store = Store(reducer: appReducer, state: nil, middleware: middlewares)
