//
//  Store.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift

var store = Store(reducer: appReducer, state: nil, middleware: [thunkMiddleware])
