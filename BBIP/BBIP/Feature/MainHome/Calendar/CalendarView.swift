//
//  CalendarView.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel = DIContainer.shared.makeCalendarViewModel()
    
    @State var selectedDate = Date()
    @State private var currentMonthTitle: String = ""
    
    private func updateCurrentMonthTitle() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM"
        currentMonthTitle = formatter.string(from: Date())
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
            }
            .frame(height: 42)
            
            
            BBIPCalendar(
                vo: viewModel.vo ?? [],
                selectedDate: $selectedDate,
                currentMonthTitle: $currentMonthTitle
            )
            .frame(height: 280)
            .padding(.vertical, 18)
            
            Rectangle()
                .foregroundStyle(.gray3)
                .frame(maxWidth: .infinity)
                .frame(height: 1)
            
            SelectedDateEventView(selectedDate: selectedDate)
        }
        .onAppear {
            viewModel.fetch(date: selectedDate)
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

#Preview {
    CalendarView()
}
