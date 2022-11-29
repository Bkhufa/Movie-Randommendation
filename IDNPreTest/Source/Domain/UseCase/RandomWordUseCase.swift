//
//  RandomWordUseCase.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 30/11/22.
//

import Foundation

class RandomWordUseCase: UseCase {
    
    private let pointOfSpeech: PartOfSpeech
    
    init(pointOfSpeech: PartOfSpeech) {
        self.pointOfSpeech = pointOfSpeech
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var apiHost: String {
        "https://random-words-api.vercel.app/"
    }
    
    var endpoint: String {
        "word/" + pointOfSpeech.rawValue
    }
    
    func map(_ data: Data) throws -> [Word] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Word].self, from: data)
    }
}
