//
//  OpenAIService.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

protocol IOpenAIService {
    func getLanguages() async throws -> LanguagesList
    
    func translate(
        _ text: String,
        sourceLanguage: String,
        targetLanguage: String
    ) async throws -> TranslationResult
}

final class OpenAIService: IOpenAIService {
    private let provider: IAsyncNetworkProvider
    private let decoder: OpenAIResponceDecoder
    
    init(provider: IAsyncNetworkProvider, decoder: OpenAIResponceDecoder) {
        self.provider = provider
        self.decoder = decoder
    }
    
    func getLanguages() async throws -> LanguagesList {
        let requestBody: OpenAIRequestBody = .init(
            messages: OpenAIMessage.languagesRequestPromt
        )
        
        let target: OpenAITarget = .init(requestBody: requestBody)
        let responce: OpenAIResponse = try await provider.sendRequest(target)
        let languagesList: LanguagesList = try decoder.decode(responce)
        
        return languagesList
    }
    
    func translate(
        _ text: String,
        sourceLanguage: String,
        targetLanguage: String
    ) async throws -> TranslationResult {
        let requestBody: OpenAIRequestBody = .init(
            messages: OpenAIMessage.translationRequestPromt(
                text,
                sourceLanguage: sourceLanguage,
                targetLanguage: targetLanguage
            )
        )
        
        let target: OpenAITarget = .init(requestBody: requestBody)
        let responce: OpenAIResponse = try await provider.sendRequest(target)
        let result: TranslationResult = try decoder.decode(responce)
        
        return result
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
    
    static func translationRequestPromt(
        _ text: String,
        sourceLanguage: String,
        targetLanguage: String
    ) -> [OpenAIMessage] {
        [
            OpenAIMessage(
                role: "system",
                content: "You are a translation assistant that provides translations in JSON format."
            ),
            OpenAIMessage(
                role: "user",
                content: """
                The source language is \(sourceLanguage). Please translate the following text to \(targetLanguage): "\(text)".

                If the input text is meaningful and has dictionary definitions, return the result in the following JSON format, where "meanings" are provided in the source language (\(sourceLanguage)):

                {
                  "translatedText": "TRANSLATED_TEXT",
                  "transcription": "TRANSCRIPTION_IF_AVAILABLE",
                  "meanings": [
                    {
                      "title": "TITLE_IN_SOURCE_LANGUAGE",
                      "description": "DESCRIPTION_IN_SOURCE_LANGUAGE"
                    }
                  ],
                  "originalLanguage": "ORIGINAL_LANGUAGE"
                }

                If the input text has no meanings or is not meaningful, return the result without the "meanings" field:

                {
                  "translatedText": "TRANSLATED_TEXT",
                  "transcription": "TRANSCRIPTION_IF_AVAILABLE",
                  "originalLanguage": "ORIGINAL_LANGUAGE"
                }

                If the input text is already in \(sourceLanguage), return the JSON without the "originalLanguage" field. Do not include any extra text or explanations. The response should be valid JSON.
                """
            )
        ]

    }
}
