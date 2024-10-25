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
                content: "You are a translation and explanation assistant that provides translations and definitions in JSON format."
            ),
            OpenAIMessage(
                role: "user",
                content: """
                The source language is \(sourceLanguage). Please translate the following text to \(targetLanguage): "\(text)".

                If the input text is already in \(sourceLanguage), return the result **without the "originalLanguage" field**, and the meanings should be in \(sourceLanguage):

                {
                  "translatedText": "TRANSLATED_TEXT",
                  "transcription": "(PHONETIC_TRANSCRIPTION)",
                  "meanings": [
                    {
                      "title": "TITLE_IN_\(sourceLanguage)",
                      "description": "DESCRIPTION_IN_\(sourceLanguage)"
                    }
                  ]
                }

                If the input text is **not in \(sourceLanguage)**, detect the **correct original language** of the input text and return the result in the following JSON format. The meanings should be in the original language of the input text:

                {
                  "translatedText": "TRANSLATED_TEXT",
                  "transcription": "(PHONETIC_TRANSCRIPTION)",
                  "meanings": [
                    {
                      "title": "TITLE_IN_ORIGINAL_LANGUAGE",
                      "description": "DESCRIPTION_IN_ORIGINAL_LANGUAGE"
                    }
                  ],
                  "originalLanguage": "DETECTED_ORIGINAL_LANGUAGE"
                }

                The value for "originalLanguage" should correctly represent the actual detected language of the input text, and the meanings should always be in the detected original language.

                If the input text has no meaning, is gibberish, or is a numerical expression, return the result without the "meanings" field but still include the phonetic transcription in parentheses.

                {
                  "translatedText": "TRANSLATED_TEXT",
                  "transcription": "(PHONETIC_TRANSCRIPTION)"
                }

                Ensure that the response is valid JSON and the meanings are always presented in the original language of the input text. Do not include any extra text or explanations.
                """
            )
        ]
    }
}
