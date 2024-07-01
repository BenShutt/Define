//
//  WordReminderObserver.swift
//  Define
//
//  Created by Ben Shutt on 09/10/2023.
//

import SwiftUI
import DictionaryAPI

/// Get and set the date of a push notification reminder notification for a word
private struct WordReminderObserver: ViewModifier {
    @EnvironmentObject private var notifications: NotificationManager
    @Binding var reminderDate: Date?
    var savedWordId: SavedWordId

    private func update() async {
        let identifier = WordReminder.identifier(for: savedWordId)
        reminderDate = await notifications.nextTriggerDate(with: identifier)
    }

    func body(content: Content) -> some View {
        content
            .task { await update() }
            .onChange(of: notifications.identifiers) { _ in
                Task { await update() }
            }
    }
}

// MARK: - View + WordReminderObserver

extension View {
    func observeWordReminder(
        reminderDate: Binding<Date?>,
        savedWordId: SavedWordId
    ) -> some View {
        modifier(WordReminderObserver(
            reminderDate: reminderDate,
            savedWordId: savedWordId
        ))
    }
}

// MARK: - WordReminderButton

struct WordReminderButton: View {

    /// The date the notification request reminding the user about this word is due
    @State private var reminderDate: Date?

    /// Word that has been saved
    var savedWord: SavedWord

    /// Called when the button is tapped
    var onTap: (Bool) -> Void

    /// Name of the image based on the reminder date
    private var systemName: String {
        reminderDate != nil ? "checkmark" : "clock"
    }

    var body: some View {
        Button(action: {
            onTap(reminderDate != nil)
        }, label: {
            Image(systemName: systemName)
                .observeWordReminder(
                    reminderDate: $reminderDate,
                    savedWordId: savedWord.id
                )
        })
    }
}

// MARK: - WordReminderView

struct WordReminderView: View {
    @State private var reminderDate: Date?
    @State private var presentedTimeRemaining: TimeRemaining?
    var savedWord: SavedWord

    private var title: String {
        savedWord.word.title
    }

    var body: some View {
        Button(action: {
            guard let reminderDate else { return }
            presentedTimeRemaining = TimeRemaining(toDate: reminderDate)
        }, label: {
            Image(systemName: "clock")
                .systemImage(size: 16)
                .foregroundStyle(Color.appGray)
                .padding(16)
                .offset(x: 16, y: -16)
        })
        .disabled(reminderDate == nil)
        .compositingGroup()
        .opacity(reminderDate == nil ? 0 : 1)
        .observeWordReminder(
            reminderDate: $reminderDate,
            savedWordId: savedWord.id
        )
        .sheet(item: $presentedTimeRemaining) { timeRemaining in
            InformationSheet(
                title: "reminder_sheet_title \(title)",
                subtitle: "reminder_sheet_subtitle \(title) \(timeRemaining.id)"
            )
        }
    }
}

// MARK: - TimeRemaining

private struct TimeRemaining: Identifiable {
    var fromDate = Date()
    var toDate: Date

    var formattedString: String {
        DateComponentsFormatter.timeInterval.string(
            from: fromDate,
            to: toDate
        ) ?? ""
    }

    var id: String {
        formattedString
    }
}
