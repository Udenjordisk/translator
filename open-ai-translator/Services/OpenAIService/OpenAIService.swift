//
//  OpenAIService.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

protocol IOpenAIService {
    func getLanguages() async throws -> Languages
}

final class OpenAIService: IOpenAIService {
    private let provider: IAsyncNetworkProvider
    private let decoder: OpenAIResponceDecoder
    
    init(provider: IAsyncNetworkProvider, decoder: OpenAIResponceDecoder) {
        self.provider = provider
        self.decoder = decoder
    }
    
    func getLanguages() async throws -> Languages {
        let requestBody: OpenAIRequestBody = .init(
            messages: OpenAIMessage.languagesRequestPromt
        )
        
        let target: OpenAITarget = .init(requestBody: requestBody)
        let responce: OpenAIResponse = try await provider.sendRequest(target)
        let languages: Languages = try decoder.decode(responce)
        
        return languages
    }
    
    func translate() {
        
    }
}

private extension OpenAIMessage {
    static let languagesRequestPromt = [
        OpenAIMessage(
            role: "system",
            content: "You are a helpful assistant that responds in strict JSON format."
        ),
        OpenAIMessage(
            role: "user",
            content: "Please return a valid JSON object where the key is 'languages' and the value is an array of supported languages. The response should contain only valid JSON, with no additional text, explanations, or formatting like code blocks (e.g., no ```json or \n). Just return the JSON object."
        )
    ]
}
