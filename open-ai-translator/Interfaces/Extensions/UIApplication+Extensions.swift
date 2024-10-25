//
//  UIApplication+endAction.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 25.10.2024.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
