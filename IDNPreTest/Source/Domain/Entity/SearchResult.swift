//
//  Movie.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//

import Foundation

// MARK: - Movie
struct SearchResult: Codable {
    let movies: [Movie]
    let totalResults: String

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
    }
}

// MARK: - Search
struct Movie: Codable {
    let title, year, imdbID: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
}
