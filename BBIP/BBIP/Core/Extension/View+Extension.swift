//
//  View+Extension.swift
//  BBIP
//
//  Created by 이건우 on 8/31/24.
//

import SwiftUI

// MARK: - NavigationBar
extension View {
    /// Navigation title이 존재하는 뷰에서 전반적으로 사용될 appearance custom 함수
    func setNavigationBarAppearance(forDarkView: Bool = false) {
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "WantedSans-Medium", size: 20)!,
            .foregroundColor: forDarkView ? UIColor.white : UIColor(hexCode: "1F1F1F")
        ]
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
