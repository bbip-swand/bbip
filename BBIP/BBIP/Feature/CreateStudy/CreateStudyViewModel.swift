//
//  CreateStudyViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/29/24.
//

import Foundation
import Combine
import UIKit

class CreateStudyViewModel: ObservableObject {
    @Published var contentData: [CreateStudyContent]
    @Published var canGoNext: [Bool] = [
        false,  // 카테고리 분야 선택
        false,  // 기간 및 주차 횟수 선택
        false,  // 스터디 프로필
        false,  // 스터디 한 줄 소개
        true   // 주차별 계획
    ]
    private var cancellables = Set<AnyCancellable>()
    
    private func sinkElements() {
        // SISPeriodView 다음 버튼 상태
        Publishers.CombineLatest3($weekCount, $periodIsSelected, $selectedDayIndex)
            .combineLatest($skipDaySelection)
            .sink { [weak self] (weekPeriodDay, skipDay) in
                guard let self = self else { return }
                let (weekCount, periodIsSelected, selectedDayIndex) = weekPeriodDay
                
                // 조건을 만족할 경우 canGoNext[1]을 true로 설정
                self.canGoNext[1] = (weekCount > 0 && periodIsSelected) && (!selectedDayIndex.isEmpty || skipDay)
            }
            .store(in: &cancellables)
        
        $selectedDayIndex
            .sink { [weak self] newValue in
                guard let self = self else { return }
                if self.skipDaySelection, !newValue.isEmpty {
                    self.skipDaySelection = false
                }
            }
            .store(in: &cancellables)
    }
    
    // 시작일로부터 주차 계산해 마감일 계산
    func calculateDeadline() {
        let addedWeeks = Calendar.current.date(
            byAdding: .weekOfYear,
            value: weekCount,
            to: startDate
        )
        deadlineDate = addedWeeks
        periodIsSelected = true
    }
    
    func initalWeeklyContentData() {
        let currentCount = weeklyContentData.count
        var newData = Array(repeating: "", count: weekCount)
        
        // 기존 데이터 중에서 유지할 데이터가 있는 경우 복사
        for index in 0..<min(currentCount, weekCount) {
            newData[index] = weeklyContentData[index] ?? ""
        }
        weeklyContentData = newData
        print(weeklyContentData.count, weeklyContentData)
    }
    
    init() {
        self.contentData = CreateStudyContent.generate()
        sinkElements()
    }
    
    // MARK: - Category Setting View
    @Published var selectedCategoryIndex: [Int] = .init()
    
    // MARK: - Period Setting View
    @Published var weekCount: Int = 12 {
        didSet {
            calculateDeadline()
            initalWeeklyContentData()
        }
    }
    @Published var periodIsSelected: Bool = false
    @Published var startDate: Date = Date()
    @Published var deadlineDate: Date? = nil
    
    @Published var selectedDayIndex: [Int] = .init()
    @Published var selectedDayStudySession: [StudySessionVO] = .init()
    func createEmptyDay() {
        selectedDayIndex.append(-1)
        selectedDayStudySession.append(.emptySession())
    }
    func deleteDay(at index: Int) {
        selectedDayIndex.remove(at: index)
        selectedDayStudySession.remove(at: index)
    }
    
    // not use
    @Published var skipDaySelection: Bool = false
    
    // MARK: - Profile Setting View
    @Published var studyName: String = .init()
    @Published var isNameValid: Bool = false
    @Published var selectedImage: UIImage? = nil
    @Published var showImagePicker: Bool = false
    @Published var hasStartedEditing: Bool = false
    
    // MARK: - Description Input View
    @Published var studyDescription: String = .init()
    
    // MARK: - Weekly Content Input View
    @Published var weeklyContentData: [String?] = []
}
