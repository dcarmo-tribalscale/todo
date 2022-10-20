//
//  ErrorTextModifier.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-13.
//

import Foundation
import SwiftUI

struct ErrorTextModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.footnote)
      .foregroundColor(.red)
      .multilineTextAlignment(.leading)
      .padding(.vertical, 4)
      .transition(.opacity)
  }
}
