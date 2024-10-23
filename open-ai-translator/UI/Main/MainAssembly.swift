//
//  MainAssembly.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import SwiftUI

struct MainAssembly {
    var openAIService: IOpenAIService {
        OpenAIService(
            provider: AsyncNetworkProvider(),
            decoder: OpenAIResponceDecoder()
        )
    }
    
    func assemble() -> some View {
        let viewModel = MainViewModel(openAIService: openAIService)
        
        let view = MainView(viewModel: viewModel)
        
        return view
    }
}
