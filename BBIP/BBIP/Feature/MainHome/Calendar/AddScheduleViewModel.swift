//
//  AddScheduleViewModel.swift
//  BBIP
//
//  Created by 이건우 on 11/14/24.
//

import Foundation
import Combine

class AddScheculeViewModel: ObservableObject {
    @Published var selectedStudyName: String?
    @Published var selectedStudyId: String = ""
    @Published var scheduleTitle: String = ""
    
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var startTime: Date?
    @Published var endTime: Date?
    
    @Published var showHome: Bool = false
    @Published var iconType: Int = -1
    
    @Published var canAddSchedule: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupCanAddScheduleBinding()
        setupShowHomeBinding()
    }
    
    /// 서버 형식, ISO 8601 format
    var startDateTimeString: String? {
        formattedDateString(from: combineDateAndTime(date: startDate, time: startTime))
    }
    
    /// 서버 형식, ISO 8601 format
    var endDateTimeString: String? {
        formattedDateString(from: combineDateAndTime(date: endDate, time: endTime))
    }
    
    /// 완료 버튼 활성화 여부 sink
    private func setupCanAddScheduleBinding() {
        Publishers.CombineLatest3(
            $selectedStudyName,
            $scheduleTitle,
            Publishers.CombineLatest(
                Publishers.CombineLatest($startDate, $endDate),
                Publishers.CombineLatest($startTime, $endTime)
            )
        )
        .map { studyName, title, dateAndTime in
            let (dates, times) = dateAndTime
            let (startDate, endDate) = dates
            let (startTime, endTime) = times
            
            guard
                let studyName = studyName, !studyName.isEmpty,
                !title.isEmpty,
                let startDate = startDate, let endDate = endDate,
                let startTime = startTime, let endTime = endTime
            else {
                return false
            }
            
            let combinedStart = self.combineDateAndTime(date: startDate, time: startTime)
            let combinedEnd = self.combineDateAndTime(date: endDate, time: endTime)
            
            // Ensure end date-time is not earlier than start date-time
            return combinedStart < combinedEnd
        }
        .assign(to: &$canAddSchedule)
    }
    
    private func setupShowHomeBinding() {
        $showHome
            .filter { !$0 } // showHome이 false 이면 iconType은 항상 -1
            .sink { [weak self] _ in
                self?.iconType = -1
            }
            .store(in: &cancellables)
    }
    
    /// 날짜와 시간을 더해 새로운 Date 객체를 return
    private func combineDateAndTime(date: Date?, time: Date?) -> Date {
        guard let date = date else { return Date() }
        guard let time = time else { return date }
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return calendar.date(from: combinedComponents) ?? date
    }
    
    /// Converts a combined `Date` into the desired string format
    private func formattedDateString(from date: Date?) -> String? {
        guard let date = date else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: date)
    }
}
