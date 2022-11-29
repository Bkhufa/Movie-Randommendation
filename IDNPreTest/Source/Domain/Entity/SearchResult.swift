//
//  Movie.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//

import Foundation

// MARK: - Movie
struct SearchResult: Codable {
    let search: [Movie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Movie: Codable {
    let title, year, imdbID: String
    let type: MovieType
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum MovieType: String, Codable {
    case movie
    case series
    case episode
}
