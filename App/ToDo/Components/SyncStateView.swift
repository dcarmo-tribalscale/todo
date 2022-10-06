//
//  SyncStateView.swift
//  ToDo
//
//  Created by TribalScale on 2022-10-06.
//

import SwiftUI

struct SyncStateView: View {

  // MARK: - Properties

  private let itemSize: CGFloat = 18

  let state: SyncState?

  // MARK: - Body

  var body: some View {
    // Tried using Group for the animation but that didn't work.
    ZStack {
      switch state {
      case .syncing:
        ProgressView()
          .frame(width: itemSize, height: itemSize)
      case .failed:
        Image(systemSymbol: .xmark)
          .resizable()
          .frame(width: itemSize, height: itemSize)
          .foregroundColor(.red)
      case .complete:
        Image(systemSymbol: .checkmark)
          .resizable()
          .frame(width: itemSize, height: itemSize)
          .foregroundColor(.green)
      default:
        EmptyView()
      }
    } //: ZStack
    .transition(.opacity)
    .animation(.easeIn(duration: 0.66), value: state)
  }
}

// MARK: - Preview

struct SyncStateView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SyncStateView(state: .syncing)
        .previewDisplayName("Syncing")
        .previewLayout(.sizeThatFits)
        .padding()

      SyncStateView(state: .failed)
        .previewDisplayName("Failed")
        .previewLayout(.sizeThatFits)
        .padding()

      SyncStateView(state: .complete)
        .previewDisplayName("Complete")
        .previewLayout(.sizeThatFits)
        .padding()
    }
  }
}
