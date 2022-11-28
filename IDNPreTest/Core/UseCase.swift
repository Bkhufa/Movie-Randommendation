//
//  UseCaseInterface.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//

import Foundation

protocol UseCase {
    
    associatedtype Response
    
    var apiHost: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }
    
    func map(_ data: Data) throws -> Response
}

extension UseCase where Response: Decodable {
    
    func map(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension UseCase {
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    var endpoint: String {
        ""
    }
}
