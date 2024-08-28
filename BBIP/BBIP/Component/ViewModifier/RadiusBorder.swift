//
//  RadiusBorder.swift
//  BBIP
//
//  Created by 이건우 on 8/27/24.
//

import SwiftUI

struct RadiusBorder: ViewModifier {
    let cornerRadius: CGFloat
    let color: Color
    let lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(color, lineWidth: lineWidth)
            )
    }
}

extension View {
    /// default color is gray2, default lineWidth is 1
    func radiusBorder(
        cornerRadius: CGFloat,
        color: Color = .gray2,
        lineWidth: CGFloat = 1
    ) -> some View {
        self
            .modifier(RadiusBorder(cornerRadius: cornerRadius, color: color, lineWidth: lineWidth))
    }
}
