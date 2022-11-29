//
//  SearchUsecase.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 29/11/22.
//

import Foundation

class SearchUseCase: UseCase {
    
    private let query: String
    private let page: Int
    
    init(query: String, page: Int) {
        self.query = query
        self.page = page
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String] {
        [
            "apikey": "8a5ee4d8",
            "s": "\(query)",
            "page": "\(page)"
        ]
    }
    
    var apiHost: String {
        "https://www.omdbapi.com/"
    }
    
    var endpoint: String {
        ""
    }
    
    func map(_ data: Data) throws -> SearchResult {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(SearchResult.self, from: data)
    }
}
