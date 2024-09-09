//
//  LoadableStyle.swift
//  BBIP
//
//  Created by 이건우 on 9/8/24.
//

import SwiftUI

struct LoadableStyle: ViewModifier {
    @Binding var isLoading: Bool
    var withBackground: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                 BBIPLottieView(assetName: "BBIPLoading", withBackground: withBackground)
                    .ignoresSafeArea(.all)
            }
        }
    }
}

extension View {
    func loadingOverlay(
        isLoading: Binding<Bool>,
        withBackground: Bool = true
    ) -> some View {
        self.modifier(LoadableStyle(isLoading: isLoading, withBackground: withBackground))
    }
}
