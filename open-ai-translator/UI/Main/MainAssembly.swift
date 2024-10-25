//
//  MainAssembly.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import SwiftUI

struct MainAssembly {
    func assemble() -> some View {
        let service = OpenAIService(
            provider: AsyncNetworkProvider(),
            decoder: OpenAIResponceDecoder()
        )
        
        let viewModel = MainViewModel(openAIService: service)
        
        let view = MainView(viewModel: viewModel)
        
        return view
    }
}
