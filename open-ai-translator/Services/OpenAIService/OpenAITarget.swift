//
//  OpenAITarget.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import Foundation

struct OpenAITarget {
    let requestBody: OpenAIRequestBody
}

extension OpenAITarget: INetworkTarget {
    var method: HTTPMethod {
        .post
    }
    
    var baseUrl: RequestBaseURL {
        .openAI
    }
    
    var path: RequestPath {
        .openAI
    }
    
    var headers: [String : String] {
        [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(String.apiKey)"
        ]
    }
    
    var body: Encodable? {
        requestBody
    }
    
    var encoder: JSONEncoder? {
        nil
    }
    
    var decoder: JSONDecoder? {
        nil
    }
}

// FIXME: - Я понимаю что ключ не должен в открытом виде лежать в приложении, но для упрощения я пропустил шифрование ключа
private extension String {
    static let apiKey = "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"
}
