//
//  OpenAIBody.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

struct OpenAIRequestBody: Encodable {
    let model: String = "gpt-4o-mini"
    let messages: [OpenAIMessage]
}
