//
//  MainView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                SkeletonView()
                    .onAppear {
                        Task.detached {
                            await viewModel.viewWillAppear()
                        }
                    }
                
            case .content:
                ContentView()
                    
            case .error:
                FullScreenErrorView()
            
            case .empty:
                EmptyView()
            }
            
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .environmentObject(viewModel)
    }
}
