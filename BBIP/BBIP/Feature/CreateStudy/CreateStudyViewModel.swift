//
//  CreateStudyViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/29/24.
//

import Foundation

class CreateStudyViewModel: ObservableObject {
    @Published var contentData: [CreateStudyContent]
    @Published var canGoNext: [Bool] = [
        false,  // 카테고리 분야 선택
        false,  // 기간 및 주차 횟수 선택
        false,  // 스터디 프로필
        false,  // 스터디 한 줄 소개
        false   // 주차별 계획
    ]
    
    // MARK: - Category Setting View
    @Published var selectedCategoryIndex: [Int] = []
    
    init() {
        self.contentData = CreateStudyContent.generate()
    }
}
