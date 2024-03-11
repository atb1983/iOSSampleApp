//
//  NetworkError.swift
//
//  Created by Alex Franco on 04/03/2024.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedUrl
    case malformedJson
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .malformedUrl:
            return NSLocalizedString("Malformed URL", comment: "NetworkError")
        case .malformedJson:
            return NSLocalizedString("Malformed JSON data", comment: "NetworkError")
        }
    }
}
