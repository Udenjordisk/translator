//
//  MainViewModel+Arbitrary.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 24.10.2024.
//

extension MainViewModel {    
    static func arbitrary(
        sourceInputText: String = "Sample text",
        targetInputText: String = "Sample text",
        sourceLanguage: String = "English",
        targetLanguage: String = "Spanish"
    ) -> MainViewModel {
        let service = OpenAIService(
            provider: AsyncNetworkProvider(),
            decoder: OpenAIResponceDecoder()
        )
        
        let model = MainViewModel(openAIService: service)
        
        model.inputText = sourceInputText
        model.sourceLanguage = sourceLanguage
        model.targetLanguage = targetLanguage
        
        return .init(openAIService: service)
    }
}
