//
//  Widget.swift
//  Widget
//
//  Created by TribalScale on 2022-10-07.
//

import WidgetKit
import SwiftUI
import SFSafeSymbols
import ToDoDatabase
import ToDoShared

struct TodoWidgetProvider: TimelineProvider {

  private func todoDisplayCount(in context: Context) -> UInt {
      if context.family == .systemSmall || context.family == .systemMedium {
        return 3
      } else {
        return 7
      }
  }

  // This is shown when the user is selecting which widget size to use. It displays as the sample in that window
  func placeholder(in context: Context) -> TodoTimelineEntry {
    let count = min(Int(todoDisplayCount(in: context)), 5)
    return TodoTimelineEntry(date: Date(), todos: Array(sampleTodos[0..<count]))
  }

  func getSnapshot(in context: Context, completion: @escaping (TodoTimelineEntry) -> Void) {
    let count = min(Int(todoDisplayCount(in: context)), 5)
    let entry = TodoTimelineEntry(date: Date(), todos: Array(sampleTodos[0..<count]))
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<TodoTimelineEntry>) -> Void) {
    let database = FirebaseDBEngine()

    Task.detached {
      do {
        let count: UInt = todoDisplayCount(in: context)

        let todos = try await database.getTodos(count: count)
        let entries = [TodoTimelineEntry(date: Date(), todos: todos)]
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
      } catch {
        print(error)
      }
    }
  }
}

struct TodoTimelineEntry: TimelineEntry {
  let date: Date
  let todos: [Todo]
}

struct TodoWidgetEntryView: View {
  var entry: TodoWidgetProvider.Entry

  var body: some View {
    VStack(alignment: .leading) {
      ForEach(entry.todos) { todo in
        HStack(alignment: .center) {
          Image(systemSymbol: todo.complete ? .checkmarkSquareFill : .square)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.blue)
            .transition(.scale)
            .animation(.easeOut, value: todo.complete)
//              .disabled(syncState != nil)
//              .onTapGesture {
//                store.dispatch(toggleComplete(on: todo))
//              }

          VStack(alignment: .leading, spacing: 6) {
            Text(todo.title)
              .font(.subheadline)
              .fontWeight(.bold)
              .multilineTextAlignment(.leading)

            Text(todo.description)
              .font(.footnote)
              .foregroundColor(.gray)
              .lineLimit(4)
              .multilineTextAlignment(.leading)
          }

          Spacer()
        }
      }

      Spacer()
    }
    .padding()
  }
}

// MARK: - Main

@main
struct TodoWidget: Widget {

  // MARK: - Properties

  let kind: String = "TodoWidget"

  // MARK: - Lifecycle

  init() {
    let database = FirebaseDBEngine()
    database.setup()
  }

  // MARK: - Body

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: TodoWidgetProvider()) { entry in
      TodoWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Todo Widget")
    .description("A widget for you to manage your Todos!")
  }
}

// MARK: - Preview

struct TodoWidget_Previews: PreviewProvider {
    static var previews: some View {

      TodoWidgetEntryView(entry: TodoTimelineEntry(date: Date(), todos: sampleTodos))
            .previewContext(WidgetPreviewContext(family: .systemSmall))

//      TodoWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//
//      TodoWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//
//      if #available(iOS 15, *) {
//        TodoWidgetEntryView(entry: SimpleEntry(date: Date()))
//          .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
//      }
    }
}
