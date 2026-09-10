// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import XCTest
@testable import JotCore

final class TranscriptionErrorTests: XCTestCase {

    // MARK: Retryable errors

    func testOfflineIsRetryable() {
        XCTAssertTrue(TranscriptionError.offline.isRetryable)
    }

    func testNetworkIsRetryable() {
        XCTAssertTrue(TranscriptionError.network("connection reset").isRetryable)
    }

    func testTimeoutIsRetryable() {
        XCTAssertTrue(TranscriptionError.timeout.isRetryable)
    }

    func testTransientRateLimitIsRetryable() {
        XCTAssertTrue(TranscriptionError.rateLimitedTransient.isRetryable)
    }

    // MARK: Non-retryable errors

    func testBadRequestIsNotRetryable() {
        XCTAssertFalse(TranscriptionError.badRequest("invalid audio").isRetryable)
    }

    func testAuthIsNotRetryable() {
        XCTAssertFalse(TranscriptionError.auth.isRetryable)
    }

    func testModelUnavailableIsNotRetryable() {
        XCTAssertFalse(TranscriptionError.modelUnavailable(model: "gemini-3.5-transcribe", detail: nil).isRetryable)
    }

    func testDailyRateLimitIsNotRetryable() {
        XCTAssertFalse(TranscriptionError.rateLimitedDaily.isRetryable)
    }

    func testEmptyTranscriptIsNotRetryable() {
        XCTAssertFalse(TranscriptionError.emptyTranscript.isRetryable)
    }

    func testSafetyBlockedIsNotRetryable() {
        XCTAssertFalse(TranscriptionError.safetyBlocked.isRetryable)
    }
}