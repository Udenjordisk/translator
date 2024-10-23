//
//  OpenAIResponce.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

struct OpenAIResponse: Decodable {
    let choices: [Choice]
}

extension OpenAIResponse {
    struct Choice: Decodable {
        let message: OpenAIMessage
    }
}
