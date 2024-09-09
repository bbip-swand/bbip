//
//  BBIPShadowStyle.swift
//  BBIP
//
//  Created by 이건우 on 9/3/24.
//

import SwiftUI

struct BBIPShadowStyle: ViewModifier {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}

extension View {
    func bbipShadow(color: Color = .black, radius: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        self.modifier(BBIPShadowStyle(color: color, radius: radius, x: x, y: y))
    }
    
    func bbipShadow1() -> some View {
        self.bbipShadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0)
    }
    
    func bbipShadow2() -> some View {
        self.bbipShadow(color: Color.black.opacity(0.15), radius: 11, x: 0, y: 0)
    }
}
