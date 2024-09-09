//
//  WordReminderObserver.swift
//  Define
//
//  Created by Ben Shutt on 09/10/2023.
//

import SwiftUI
import DictionaryAPI
import AppIcon

// TODO: Have seen a bug where the clock/modal said 2 weeks on first launch

/// Get and set the date of a push notification reminder notification for a word
private struct WordReminderObserver: ViewModifier {
    @EnvironmentObject private var notifications: NotificationManager
    @Binding var reminderDate: Date?
    var savedWord: SavedWord

    private func update() async {
        let identifier = WordReminder.identifier(for: savedWord)
        reminderDate = await notifications.nextTriggerDate(with: identifier)
    }

    func body(content: Content) -> some View {
        content
            .task { await update() }
            .onChange(of: notifications.identifiers) {
                Task { await update() }
            }
    }
}

// MARK: - View + WordReminderObserver

extension View {
    func observeWordReminder(
        reminderDate: Binding<Date?>,
        savedWord: SavedWord
    ) -> some View {
        modifier(WordReminderObserver(
            reminderDate: reminderDate,
            savedWord: savedWord
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
    private var systemName: SystemImage {
        reminderDate != nil ? .checkmark : .clock
    }

    var body: some View {
        Button(action: {
            onTap(reminderDate != nil)
        }, label: {
            Image(systemName)
                .observeWordReminder(
                    reminderDate: $reminderDate,
                    savedWord: savedWord
                )
                .accessibilityHidden(true)
        })
    }
}

// MARK: - WordReminderView

struct WordReminderView: View {
    @State private var reminderDate: Date?
    @State private var presentedTimeRemaining: TimeRemaining?
    var savedWord: SavedWord

    private var title: String {
        savedWord.model.title
    }

    var body: some View {
        Button(action: {
            guard let reminderDate else { return }
            presentedTimeRemaining = TimeRemaining(toDate: reminderDate)
        }, label: {
            Image(.clock)
                .systemImage(size: 16)
                .foregroundStyle(Color.appGray)
                .padding(16)
                .offset(x: 16, y: -16)
                .accessibilityHidden(true)
        })
        .disabled(reminderDate == nil)
        .opacity(reminderDate == nil ? 0 : 1)
        .observeWordReminder(
            reminderDate: $reminderDate,
            savedWord: savedWord
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
