//
//  NetworkService.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import Foundation

final class AsyncNetworkProvider: IAsyncNetworkProvider {
    func sendRequest<D: Decodable>(_ target: INetworkTarget) async throws -> D {
        let request = try createRequest(target)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = target.decoder ?? JSONDecoder()
        
        let decodedResult = try decoder.decode(D.self, from: data)
        
        return decodedResult
    }
}

private extension AsyncNetworkProvider {
    func createRequest(_ target: INetworkTarget) throws -> URLRequest {        
        guard let url = URL(string: "\(target.baseUrl.rawValue)/\(target.path.rawValue)") else {
            throw NetworkProviderError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = target.method.rawValue
        
        target.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = target.body {
            let encoder = target.encoder ?? JSONEncoder()
            request.httpBody = try encoder.encode(body)
        }
        
        return request
    }
}
