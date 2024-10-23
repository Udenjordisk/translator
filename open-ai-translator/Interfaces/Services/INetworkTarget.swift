//
//  INetworkTarget.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol INetworkTarget {
    var method: HTTPMethod { get }
    var baseUrl: RequestBaseURL { get }
    var path: RequestPath { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
    var encoder: JSONEncoder? { get }
    var decoder: JSONDecoder? { get }
}
