//
//  CalendarView.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI
import SwiftUIIntrospect

struct CalendarView: View {
    @StateObject var viewModel: CalendarViewModel = DIContainer.shared.makeCalendarViewModel()
    @State private var selectedDate = Date()
    @State private var currentMonthTitle: String = ""
    @State private var showAddScheduleView: Bool = false
    
    private var ongoingStudyData: [StudyInfoVO]?
    
    private func updateCurrentMonthTitle() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM"
        currentMonthTitle = formatter.string(from: Date())
    }
    
    init(ongoingStudyData: [StudyInfoVO]? = nil) {
        self.ongoingStudyData = ongoingStudyData
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(currentMonthTitle)
                    .font(.bbip(.title4_sb24))
                    .foregroundStyle(.gray9)
                    .onAppear {
                        updateCurrentMonthTitle()
                    }
                    .padding(.leading, 20)
                
                Spacer()
                
                Button {
                    showAddScheduleView = true
                } label: {
                    Image("calendar_add")
                        .padding(.trailing, 28)
                }
            }
            .frame(height: 42)
            
            Group {
                if let scheduleData = viewModel.vo {
                    BBIPCalendar(
                        vo: scheduleData,
                        selectedDate: $selectedDate,
                        currentMonthTitle: $currentMonthTitle
                    )
                    .id(scheduleData.count)
                } else {
                    BBIPCalendar(
                        vo: [],
                        selectedDate: $selectedDate,
                        currentMonthTitle: $currentMonthTitle
                    )
                }
            }
            .frame(height: 280)
            .padding(.vertical, 18)
            
            Rectangle()
                .foregroundStyle(.gray3)
                .frame(maxWidth: .infinity)
                .frame(height: 1)
            
            Group {
                if let scheduleData = viewModel.vo {
                    SelectedDateEventView(selectedDate: selectedDate, schedules: scheduleData)
                } else {
                    SelectedDateEventView(selectedDate: selectedDate, schedules: [])
                }
            }
        }
        .navigationDestination(isPresented: $showAddScheduleView) {
            AddScheduleView(ongoingStudyData: ongoingStudyData)
        }
        .onAppear {
            viewModel.fetch(date: selectedDate)
        }
    }
}

private struct SelectedDateEventView: View {
    var selectedDate: Date
    var schedules: [ScheduleVO]
    
    private func formattedDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    private func formattedWeekday(for date: Date) -> String {
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.locale = Locale(identifier: "ko_KR")
        weekdayFormatter.dateFormat = "E"
        return weekdayFormatter.string(from: date)
    }
    
    private func schedulesForSelectedDate() -> [ScheduleVO] {
        let calendar = Calendar.current
        return schedules.filter { schedule in
            return calendar.isDate(selectedDate, inSameDayAs: schedule.startDate) ||
            calendar.isDate(selectedDate, inSameDayAs: schedule.endDate) ||
            (selectedDate >= schedule.startDate && selectedDate <= schedule.endDate)
        }
    }
    
    var body: some View {
        ZStack {
            Color.gray1
            
            VStack(spacing: 12) {
                HStack(spacing: 5) {
                    Text(formattedDate(for: selectedDate))
                        .monospacedDigit()
                        .font(.bbip(.title3_sb20))
                    
                    Text(formattedWeekday(for: selectedDate))
                        .font(.bbip(.title3_m20))
                    
                    Spacer()
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 20)
                
                if schedulesForSelectedDate().isEmpty {
                    Spacer()
                    Image("calendar_placeholder")
                        .padding(.bottom, 92) // tabbar size
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(schedulesForSelectedDate(), id: \.scheduleId) { schedule in
                                ScheduleCardView(schedule: schedule)
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 100)
                    }
                    .bbipShadow1()
                    .scrollIndicators(.never)
                }
                Spacer()
            }
            .padding(.vertical, 22)
        }
    }
}

#Preview {
    CalendarView()
}
