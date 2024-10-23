//
//  MainViewModel.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    
    enum State {
        case loading
        case content
        case error
    }
    
    private let openAIService: IOpenAIService
    
    @Published var state: State = .loading
    @Published var languages: [String] = []
    
    init(openAIService: IOpenAIService) {
        self.openAIService = openAIService
    }
    
    func viewWillAppear() async {
        await loadLanguages()
    }
}

private extension MainViewModel {
    func loadLanguages() async {
        do {
            let result = try await openAIService.getLanguages()
                
            Task { @MainActor in
                languages = result.languages
            }
            await updateState(.content)
        } catch {
            await updateState(.error)
        }
    }
    
    @MainActor
    func updateState(_ newValue: State) {
        state = newValue
    }
}

func prettyPrintJSON(from data: Data) -> String? {
    do {
        // Декодируем JSON из Data
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        
        // Преобразуем объект обратно в красиво форматированную строку JSON
        let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        
        // Преобразуем Data в строку
        if let prettyJsonString = String(data: prettyJsonData, encoding: .utf8) {
            return prettyJsonString
        } else {
            return nil
        }
    } catch {
        print("Ошибка при преобразовании JSON: \(error)")
        return nil
    }
}

struct Languages: Decodable {
    var languages: [String]
}
