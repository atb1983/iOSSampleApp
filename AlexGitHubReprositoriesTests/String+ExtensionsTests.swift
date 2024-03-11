//
//  String+ExtensionsTests.swift
// Tests
//
//  Created by Alex on 02/03/2024.
//

import Foundation
import XCTest
@testable import AlexGitHubReprositories

class String_ExtensionsTests: XCTestCase {
    func test_uppercasingFirstWith1Word() {
        XCTAssertEqual("test".uppercasingFirst, "Test")
    }
    
    func test_uppercasingFirstWith2words() {
        XCTAssertEqual("test test".uppercasingFirst, "Test test")
    }
    
    func test_uppercasingFirstWithEmptyString() {
        XCTAssertEqual("".uppercasingFirst, "")
    }
}
