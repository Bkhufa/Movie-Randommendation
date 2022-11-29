//
//  Word.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 30/11/22.
//

import Foundation

struct Word: Decodable {
    let word: String
    let definition: String
}

struct WordWithPoS {
    let word: Word
    let pos: PartOfSpeech
}

enum PartOfSpeech: String {
    case noun
    case verb
    case adjective
}
