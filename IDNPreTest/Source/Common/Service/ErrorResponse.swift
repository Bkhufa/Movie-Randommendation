//
//  ErrorResponse.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//

import Foundation

enum ErrorResponse: Error {
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

struct MovieError: Decodable, Error {
    let error: String
    enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}
