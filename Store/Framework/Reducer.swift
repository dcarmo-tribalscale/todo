//
//  Reducer.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-03.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
  AppState(
    todoState: TodoState.reducer(action: action, state: state?.todoState)
  )
}
