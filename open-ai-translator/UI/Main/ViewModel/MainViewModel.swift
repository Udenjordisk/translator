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
    
    @Published var sourceText: String = ""
    @Published var translatedText: String = ""
    @Published var transcription: String? = nil
    @Published var meanings: [TranslationResult.Meaning] = []
    
    private var subscriptions = Set<AnyCancellable>()

    init(openAIService: IOpenAIService) {
        self.openAIService = openAIService
    }
    
    func viewWillAppear() async {
        await loadLanguages()
        subscribe()
    }
    
    @MainActor
    func updateState(_ newValue: State) {
        state = newValue
    }
    
    @MainActor
    func swapLanguages() {
        swap(&sourceLanguage, &targetLanguage)
        swap(&sourceText, &translatedText)
    }
    
    @MainActor
    func updateSourceLanguage(_ newValue: String) {
        sourceLanguage = newValue
    }
    
    func copy() {
        UIPasteboard.general.string = translatedText
    }
    
    @MainActor
    func clear() {
        sourceText.removeAll()
    }
}

private extension MainViewModel {
    func subscribe() {
        Publishers.CombineLatest3($sourceText, $sourceLanguage, $targetLanguage)
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
            
            await handleTranslationResult(result)
        } catch {
            print(error)
            // translation error
        }
    }
    
    @MainActor
    func handleTranslationResult(_ result: TranslationResult) {
        guard !sourceText.isEmpty else { return }
        
        translatedText = result.translatedText
        originalLanguage = result.originalLanguage
        meanings = result.meanings
        transcription = result.transcription
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
}
