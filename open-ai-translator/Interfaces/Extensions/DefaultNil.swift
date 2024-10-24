//
//  DefaultNil.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 24.10.2024.
//

import BetterCodable

/// Декодинг опциональных полей, с установкой `nil` по умолчанию, вместо ошибки.
typealias DefaultNil<T> = DefaultCodable<DefaultNilStrategy<T>> where T: Decodable
