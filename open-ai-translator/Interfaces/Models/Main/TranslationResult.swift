//
//  TranslationResult.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 24.10.2024.
//

import Foundation
import BetterCodable

struct TranslationResult: Decodable {
    let translatedText: String
    
    @DefaultNil
    var transcription: String?
    
    @DefaultNil
    var originalLanguage: String?
    
    @DefaultEmptyArray
    var meanings: [Meaning]
}

extension TranslationResult {
    struct Meaning: Decodable {
        var title: String
        var description: String
    }
}
