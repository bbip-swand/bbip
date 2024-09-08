//
//  LoadableStyle.swift
//  BBIP
//
//  Created by 이건우 on 9/8/24.
//

import SwiftUI

struct LoadableStyle: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                BBIPLottieView(assetName: "BBIPLoading")
            }
        }
    }
}

extension View {
    func loadingOverlay(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadableStyle(isLoading: isLoading))
    }
}
