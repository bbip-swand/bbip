//
//  BBIPCalendar.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI
import FSCalendar

struct BBIPCalendar: UIViewRepresentable {
    @StateObject var calendarviewModel = DIContainer.shared.makeCalendarVieModel()
    @Binding var currentMonthTitle: String
    @Binding var selectedDate: Date
    @Binding var currentYear: String
    @Binding var currentMonth: String
    @State var vo: [CalendarHomeVO]
    var onPageChange: (String, String) -> Void
    
    init(
        vo: [CalendarHomeVO],
        selectedDate: Binding<Date>,
        currentMonthTitle: Binding<String>,
        currentYear: Binding<String>,
        currentMonth: Binding<String>,
        onPageChange: @escaping (String, String) -> Void
    ) {
        self.vo = vo
        self._selectedDate = selectedDate
        self._currentMonthTitle = currentMonthTitle
        self._currentYear = currentYear
        self._currentMonth = currentMonth
        self.onPageChange = onPageChange
    }

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
        calendar.placeholderType = .none

        // 일요일만 빨간색 (상단 요일)
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = .primary3

        // 좌우 inset
        calendar.calendarWeekdayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.calendarWeekdayView.leadingAnchor.constraint(equalTo: calendar.leadingAnchor, constant: 20),
            calendar.calendarWeekdayView.trailingAnchor.constraint(equalTo: calendar.trailingAnchor, constant: -20),
            calendar.calendarWeekdayView.heightAnchor.constraint(equalToConstant: 10)
        ])
        calendar.collectionViewLayout.sectionInsets = .init(top: 0, left: 20, bottom: 0, right: 20)

        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: BBIPCalendar

        init(_ parent: BBIPCalendar) {
            self.parent = parent
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }

        // 페이지 변경 후 처리
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            let currentPage = calendar.currentPage
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy.MM"

            let calendarComponents = Calendar.current.dateComponents([.year, .month], from: currentPage)
            if let year = calendarComponents.year, let month = calendarComponents.month {
                parent.currentYear = String(year)
                parent.currentMonth = String(format: "%02d", month)
                print("Page Changed Year: \(parent.currentYear), Month: \(parent.currentMonth)")

                // 현재 월 텍스트 업데이트
                parent.currentMonthTitle = formatter.string(from: currentPage)

                // 페이지 변경 시 getYearMonth 호출
                parent.onPageChange(parent.currentYear, parent.currentMonth)
            }

            calendar.reloadData()
        }
    }
}
