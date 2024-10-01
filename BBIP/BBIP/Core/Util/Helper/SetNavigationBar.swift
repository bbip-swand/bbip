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
        print("setNavigationBarAppearance")
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "WantedSans-Medium", size: 20)!,
            .foregroundColor: forDarkView ? UIColor.white : UIColor(hexCode: "1F1F1F")
        ]
    }
    
    func removeScrollEdgeAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
    }
}


