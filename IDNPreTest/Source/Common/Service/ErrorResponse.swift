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
