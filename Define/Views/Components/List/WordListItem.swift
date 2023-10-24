//
//  WordListItem.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI
import DictionaryAPI

/// `ListItemView` for a `Word`
struct WordListItem: View {

    /// `Word`
    var word: Word

    /// Caption text
    var caption: LocalizedStringKey?

    /// Is there a reminder PN scheduled for this word
    var isScheduled = false

    var body: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .leading, spacing: .small) {
                Text(verbatim: word.title)
                    .h2()

                if let subtitle = word.subtitle {
                    Text(subtitle)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .body()
                }

                if let nMore = word.nMore {
                    Text(nMore)
                        .caption(textColor: .appBlue)
                }

                if !word.partsOfSpeech.isEmpty {
                    PartsOfSpeechView(partsOfSpeech: word.partsOfSpeech)
                        .padding(.top, .small)
                }

                if let caption {
                    Text(caption)
                        .caption()
                        .padding(.top, .small)
                }
            }
            .listItem()

            ChevronView()
        }
        .overlay(alignment: .topTrailing) {
            if isScheduled {
                ReminderView(word: word)
            }
        }
        .padding(.large)
        .background(Color.appWhite)
    }
}

// MARK: - PartsOfSpeechView

private struct PartsOfSpeechView: View {

    var partsOfSpeech: [String]

    var body: some View {
        NoBounceScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .small) {
                ForEach(partsOfSpeech, id: \.self) {
                    WordCategoryView(category: $0)
                }
            }
        }
    }
}

// MARK: - ReminderView

private struct ReminderView: View {

    @State private var timeRemaining: TimeRemaining?
    var word: Word

    private func updateTimeRemaining() async {
        let triggerDate = await ReminderNotification.nextTriggerDate(for: word)
        if let triggerDate {
            timeRemaining = TimeRemaining(toDate: triggerDate)
        }
    }

    var body: some View {
        Button(action: {
            Task {
                await updateTimeRemaining()
            }
        }, label: {
            Image(systemName: "clock")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.appDarkGray)
                .padding(16)
                .offset(x: 16, y: -16)
        })
        .sheet(item: $timeRemaining) { timeRemaining in
            InformationSheet(
                title: "reminder_sheet_title \(word.title)",
                subtitle: "reminder_sheet_subtitle \(word.title) \(timeRemaining.id)"
            )
            .onReceiveTimer {
                await updateTimeRemaining()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    WordListItem(word: .preview, isScheduled: true)
        .screen()
}
