//
//  BBIPCalendar.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI
import FSCalendar

struct BBIPCalendar: UIViewRepresentable {
    @Binding var selectedDate: Date?
    @ObservedObject var viewModel: CalendarViewModel = .init()

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        // 헤더 삭제
        calendar.headerHeight = 0
        
        // 폰트 설정
        calendar.appearance.weekdayFont = UIFont(name: "WantedSans-Medium", size: 12)
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleFont = UIFont(name: "WantedSans-Bold", size: 14)
        
        // 오늘 날짜 컬러 (선택, 미선택)
        calendar.appearance.todayColor = .primary3
        calendar.appearance.selectionColor = .primary3
        
        // 이벤트 Dot
        calendar.appearance.eventSelectionColor = .primary3
        calendar.appearance.eventOffset = .init(x: 0, y: 2)
        calendar.placeholderType = .fillHeadTail
        
        // 일요일만 빨간색
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = .primary3
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: BBIPCalendar
        private var lastContentOffset: CGFloat = 0

        init(_ parent: BBIPCalendar) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
            calendar.appearance.todayColor = .primary1
            calendar.appearance.titleTodayColor = .black
            
            calendar.calendarWeekdayView.weekdayLabels[0].textColor = .primary3
        }
        
        // 일요일 날짜 색상 설정
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            let weekday = Calendar.current.component(.weekday, from: date)
            if weekday == 1 { // 일요일인 경우
                return UIColor.red
            } else {
                return nil
            }
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            return parent.viewModel.vo.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) })?.events.count ?? 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            let currentMonth = Calendar.current.dateComponents([.year, .month], from: calendar.currentPage)
            let dateComponents = Calendar.current.dateComponents([.year, .month], from: date)
            
            if currentMonth == dateComponents {
                return [.primary3] // 현재 월의 이벤트 색상
            } else {
                return [.primary2] // placeholder 날짜의 색상
            }
        }
        
        // 페이지 변경 후 처리
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            calendar.reloadData()
        }
    }
}
