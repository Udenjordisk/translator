//
//  MainViewModel.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    
    enum State {
        case loading
        case content
        case error
    }

    private let openAIService: IOpenAIService
    
    @Published var state: State = .loading
    
    @Published var languages: [String] = []
    
    @Published var sourceLanguage: String = ""
    @Published var targetLanguage: String = ""
    @Published var originalLanguage: String? = nil
    
    @Published var inputText: String = ""
    @Published var translatedText: String = ""
    
    private var subscriptions = Set<AnyCancellable>()

    init(openAIService: IOpenAIService) {
        self.openAIService = openAIService
    }
    
    func subscribe() {
        Publishers.CombineLatest3($inputText, $sourceLanguage, $targetLanguage)
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] text, sourceLanguage, targetLanguage in
                guard let self else { return }
                
                Task {
                    await self.translate(
                        text,
                        from: sourceLanguage,
                        to: targetLanguage
                    )
                }
            }
            .store(in: &subscriptions)
    }
    
    func viewWillAppear() async {
        await loadLanguages()
        subscribe()
    }
    
    @MainActor
    func swapLanguages() {
        swap(&sourceLanguage, &targetLanguage)
    }
}

extension MainViewModel {
    func copy() {
        UIPasteboard.general.string = translatedText
    }
    
    func clear() {
        sourceLanguage = ""
    }
}

private extension MainViewModel {
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String) async {
        guard !text.isEmpty else {
            Task { @MainActor in
                translatedText = ""
            }
            return
        }
        
        do {
            let result = try await openAIService.translate(
                text,
                sourceLanguage: sourceLanguage,
                targetLanguage: targetLanguage
            )
            
            Task { @MainActor in
                translatedText = result.translatedText
                originalLanguage = result.originalLanguage
            }
        } catch {
            print(error)
            // translation error
        }
    }
}

private extension MainViewModel {
    func loadLanguages() async {
        do {
            let result = try await openAIService.getLanguages()
                
            guard !result.languages.isEmpty else {
                await updateState(.error)
                return
            }
            
            await handleLanguagesResult(result)
        } catch {
            await updateState(.error)
        }
    }
    
    @MainActor
    func handleLanguagesResult(_ result: LanguagesList) async {
        
        self.languages = result.languages
        
        // TODO: - Сохранение значений в AppStorage
        sourceLanguage = self.languages.first ?? ""
        targetLanguage = self.languages.dropFirst().first ?? ""
        
        updateState(.content)
    }
    
    @MainActor
    func updateState(_ newValue: State) {
        state = newValue
    }
}
