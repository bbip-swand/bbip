//
//  HideKeyboard.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func keyboardHideable() -> some View {
        self
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
    }
}
