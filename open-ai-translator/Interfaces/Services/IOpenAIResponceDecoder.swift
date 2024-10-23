//
//  Untitled.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import Foundation

protocol IOpenAIResponceDecoder {
    func decode<D: Decodable>(_ value: OpenAIResponse) throws -> D
}
