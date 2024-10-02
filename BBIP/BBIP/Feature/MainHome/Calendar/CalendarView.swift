//
//  CalendarView.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var calendarviewModel = DIContainer.shared.makeCalendarVieModel()
    @State var addScheduleView = false
    @State var selectedDate = Date()
    @State private var currentMonthTitle: String = ""
    @State private var currentYear: String = ""
    @State private var currentMonth: String = ""

    private func updateCurrentMonthTitle() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM"
        let currentDate = Date()
        currentMonthTitle = formatter.string(from: currentDate)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)

        if let year = components.year, let month = components.month {
            currentYear = String(year)
            currentMonth = String(format: "%02d", month)
            print("Updated Year: \(currentYear), Updated Month: \(currentMonth)")
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(currentMonthTitle)
                    .font(.bbip(.title4_sb24))
                    .foregroundStyle(.gray9)
                    .padding(.leading, 20)
                    .onAppear {
                        updateCurrentMonthTitle()
                    }
                
                Spacer()
                
                Button {
                    addScheduleView = true
                } label: {
                    Image("add_schedule")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 28)
                }
            }
            .frame(height: 42)
            
            BBIPCalendar(
                vo: calendarviewModel.getYMdata,
                selectedDate: $selectedDate,
                currentMonthTitle: $currentMonthTitle,
                currentYear: $currentYear,
                currentMonth: $currentMonth,
                onPageChange: { year, month in
                     calendarviewModel.getYearMonth(year: year, month: month)
                 }
            )
            .frame(height: 280)
            .padding(.vertical, 18)
            
            Rectangle()
                .foregroundStyle(.gray3)
                .frame(maxWidth: .infinity)
                .frame(height: 1)
            
            SelectedDateEventView(selectedDate: selectedDate)
        }
        .navigationDestination(isPresented: $addScheduleView) {
            CreateSchedule()
        }
        .onAppear {
            // 초기 화면 진입 시 현재 연도와 월 정보로 업데이트
            updateCurrentMonthTitle()
            calendarviewModel.getYearMonth(year: currentYear, month: currentMonth)
        }
    }
}


private struct SelectedDateEventView: View {
    var selectedDate: Date
    
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
    
    var body: some View {
        ZStack {
            Color.gray1
            
            VStack {
                HStack(spacing: 5) {
                    Text(formattedDate(for: selectedDate))
                        .monospacedDigit()
                        .font(.bbip(.title3_sb20))
                    
                    Text(formattedWeekday(for: selectedDate))
                        .font(.bbip(.title3_m20))
                    
                    Spacer()
                }
                .foregroundStyle(.black)
                
                Spacer()
            }
            .padding(.vertical, 22)
            .padding(.horizontal, 20)
        }
    }
}

