//
//  OnboardingContent.swift
//  BBIP
//
//  Created by 이건우 on 8/11/24.
//

import Foundation

struct OnboardingContent: Hashable {
    let firstTitle: String
    let secondTitle: String
    let imageName: String
}

extension OnboardingContent {
    static func generate() -> [OnboardingContent] {
        return [
            OnboardingContent(firstTitle: "한눈에 보이는 학습", secondTitle: "함께하는 도전1", imageName: "onboarding_1"),
            OnboardingContent(firstTitle: "두눈에 보이는 학습", secondTitle: "함께하는 도전2", imageName: "onboarding_2"),
            OnboardingContent(firstTitle: "세눈에 보이는 학습", secondTitle: "함께하는 도전3", imageName: "onboarding_3"),
            OnboardingContent(firstTitle: "네눈에 보이는 학습", secondTitle: "함께하는 도전4", imageName: "onboarding_4")
        ]
    }
}
