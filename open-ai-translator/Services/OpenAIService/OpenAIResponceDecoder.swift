//
//  OpenAIResponceDecoder.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import Foundation

/// Сервис для обработки ответа от OpenAI API  и декодинга ответа в нужную нам модель
final class OpenAIResponceDecoder: IOpenAIResponceDecoder {
    func decode<D: Decodable>(_ value: OpenAIResponse) throws -> D {
        guard
            let message = value.choices.first?.message,
            let data = message.content.data(using: .utf8)
        else {
            throw OpenAIDecodingError.responceIsNotValidJSON
        }
        
        return try JSONDecoder().decode(D.self, from: data)
    }
}

private enum OpenAIDecodingError: Error {
    case responceIsNotValidJSON
}
