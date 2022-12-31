import XCTest
@testable import DictionaryAPI

final class DictionaryAPITests: XCTestCase {

    func testWord() async throws {
        _ = try await EntriesAPI.request(word: "hello")
    }
}
