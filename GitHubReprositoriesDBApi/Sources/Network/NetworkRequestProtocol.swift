//
//  NetworkRequestProtocol.swift
//
//  Created by Alex Franco on 04/03/2024.
//

import Foundation

public protocol NetworkRequestProtocol {
    func httpGetAsString(from urlString: String) async throws -> String
    func httpGet(from urlString: String) async throws -> Data
    
}
