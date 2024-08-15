//
//  ExportManager.swift
//  Define
//
//  Created by Ben Shutt on 15/08/2024.
//

import Foundation
import SwiftData
import Utilities

@MainActor class ExportManager: ObservableObject {
    @Published var jsonFileURL: JSONFileURL?

    func export(modelContext: ModelContext) {
        Task {
            let export = JSONExport(modelContext: modelContext)
            let url = try await export.export()
            jsonFileURL = JSONFileURL(url: url)
        }
    }

    func clean(modelContext: ModelContext) {
        Task {
            jsonFileURL = nil
            let export = JSONExport(modelContext: modelContext)
            try? await export.clean()
        }
    }
}

// MARK: - JSONFileURL

struct JSONFileURL: Identifiable {
    let id = UUID()
    var url: URL

    var item: ActivityItemSource {
        .init(
            title: String(localized: "export_share_title"),
            url: url
        )
    }
}

// MARK: - JSONExport

private struct JSONExport {
    var modelContext: ModelContext

    private var fileURL: URL {
        get throws {
            try FileManager.default.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appending(path: "words-export.json")
        }
    }

    private func export(to url: URL) throws -> URL {
        let savedWords = try modelContext.fetch(FetchDescriptor<SavedWord>())
        let words = savedWords.map { $0.model }
        let data = try JSONEncoder.pretty.encode(words)
        try data.write(to: url, options: .atomic)
        return url
    }

    func export() async throws -> URL {
        try export(to: fileURL)
    }

    func clean() async throws {
        try FileManager.default.removeItem(at: fileURL)
    }
}
