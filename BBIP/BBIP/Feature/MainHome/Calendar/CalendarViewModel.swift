//
//  CalendarViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import Foundation
import SwiftUI

final class CalendarViewModel: ObservableObject {
    @Published var vo: [CalendarVO] = mock()
    @Published var selectedDate: Date = Date()
    
    private let getMonthlyScheduleUseCase: GetMonthlyScheduleUseCaseProtocol
    
    init(getMonthlyScheduleUseCase: GetMonthlyScheduleUseCaseProtocol) {
        self.getMonthlyScheduleUseCase = getMonthlyScheduleUseCase
    }
    
}

extension CalendarViewModel {
    static func mock() -> [CalendarVO] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        return [
            CalendarVO(date: formatter.date(from: "2024/09/11")!, events: [
                CalendarVO.StudyEvent(studyName: "포트폴리오 스터디", eventTitle: "포트폴리오 2차 제출", eventTime: "09:00"),
                CalendarVO.StudyEvent(studyName: "포트폴리오 스터디", eventTitle: "포트폴리오 2차 제출", eventTime: "09:00")
            ]),
            CalendarVO(date: formatter.date(from: "2024/09/15")!, events: [
                CalendarVO.StudyEvent(studyName: "포트폴리오 스터디", eventTitle: "포트폴리오 2차 제출", eventTime: "09:00"),
                CalendarVO.StudyEvent(studyName: "포트폴리오 스터디", eventTitle: "포트폴리오 2차 제출", eventTime: "09:00")
            ]),
            CalendarVO(date: formatter.date(from: "2024/09/20")!, events: [
                CalendarVO.StudyEvent(studyName: "포트폴리오 스터디", eventTitle: "포트폴리오 2차 제출", eventTime: "09:00")
            ]),
            CalendarVO(date: formatter.date(from: "2024/10/03")!, events: [
                CalendarVO.StudyEvent(studyName: "포트폴리오 스터디", eventTitle: "포트폴리오 2차 제출", eventTime: "09:00")
            ]),
        ]
    }
}
