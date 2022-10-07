//
//  InputFieldView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-05.
//

import SwiftUI

struct InputFieldView: View {

  // MARK: - Properties

  let title: String
  let placeholder: String
  @Binding var error: String
  @Binding var value: String

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title)
        .font(.system(size: 18, weight: .bold, design: .default))

      if !error.isEmpty {
        Text(error)
          .font(.footnote)
          .foregroundColor(.red)
          .multilineTextAlignment(.leading)
          .padding(.vertical, 4)
          .transition(.opacity)
      }

      TextField(placeholder, text: $value)
        .padding(8)
        .background(Color(UIColor.tertiarySystemFill))
        .cornerRadius(9)
        .font(.system(size: 18, weight: .bold, design: .default))
        .transition(.slide)
    } //: VStack
    .animation(.easeOut(duration: 0.33), value: error)
  }
}

// MARK: - Preview

struct InputFieldView_Previews: PreviewProvider {
  static var previews: some View {
    InputFieldView(title: "Title", placeholder: "Title", error: .constant(""), value: .constant(""))
      .previewLayout(.sizeThatFits)
      .previewDisplayName("Without Error")
      .padding()

    InputFieldView(title: "Title", placeholder: "Title", error: .constant("Something went wrong"), value: .constant(""))
      .previewDisplayName("With Error")
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
