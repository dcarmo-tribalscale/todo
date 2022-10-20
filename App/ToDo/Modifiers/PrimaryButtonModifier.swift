//
//  PrimaryButtonModifier.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-12.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {

  let isDisabled: Bool
  init(isDisabled: Bool = false) {
    self.isDisabled = isDisabled
  }

  func body(content: Content) -> some View {
    content
      .font(.system(size: 24, weight: .bold, design: .default))
      .padding()
      .frame(minWidth: 0, maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 9)
          .fill(isDisabled ? .blue.opacity(0.44) : .blue)
      )
      .foregroundColor(.white)
  }
}
