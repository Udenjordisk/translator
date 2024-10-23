//
//  INetworkService.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import Foundation

protocol IAsyncNetworkProvider {
    func sendRequest<D: Decodable>(_ target: INetworkTarget) async throws -> D
}
