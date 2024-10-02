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

        init(_ parent: BBIPCalendar) {
            self.parent = parent
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
         
            if parent.selectedDate != date {
                calendar.deselect(parent.selectedDate) // 이전 선택 해제
            }
            parent.selectedDate = date
            calendar.reloadData() // 선택 상태 업데이트 후 UI 갱신
        }

        // 일요일 날짜의 글씨를 빨간색으로 설정
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            let weekday = Calendar.current.component(.weekday, from: date)
            if weekday == 1 {
                return .red // 일요일은 빨간색
            } else {
                return .black // 나머지 날짜는 검은색
            }
        }

        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let relevantEvents = parent.vo.filter { event in
                Calendar.current.isDate(date, inSameDayAs: event.startDate) ||
                Calendar.current.isDate(date, inSameDayAs: event.endDate) ||
                (date > event.startDate && date < event.endDate)
            }
            return min(relevantEvents.count, 3) // 한 날짜에 최대 3개의 점을 표시
        }

        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            let currentMonth = Calendar.current.dateComponents([.year, .month], from: calendar.currentPage)
            let dateComponents = Calendar.current.dateComponents([.year, .month], from: date)
            
            if currentMonth == dateComponents && parent.vo.contains(where: { event in
                Calendar.current.isDate(date, inSameDayAs: event.startDate) ||
                Calendar.current.isDate(date, inSameDayAs: event.endDate) ||
                (date > event.startDate && date < event.endDate)
            }) {
                return [.primary3]
            } else {
                return nil
            }
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

                // 현재 월 텍스트 업데이트
                parent.currentMonthTitle = formatter.string(from: currentPage)

                // 페이지 변경 시 getYearMonth 호출
                parent.onPageChange(parent.currentYear, parent.currentMonth)
            }

            calendar.reloadData()
        }
    }
}

