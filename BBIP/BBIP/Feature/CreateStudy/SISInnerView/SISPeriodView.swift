//
//  SISPeriodView.swift
//  BBIP
//
//  Created by 이건우 on 8/31/24.
//

import SwiftUI
import SwiftUIIntrospect

struct SISPeriodView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    @State private var showDatePicker: Bool = false
    private let sheetMode: Bool
    
    init(
        viewModel: CreateStudyViewModel,
        sheetMode: Bool = false
    ) {
        self.viewModel = viewModel
        self.sheetMode = sheetMode
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("주차 선택")
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.mainWhite)
                    .padding(.top, sheetMode ? 40 : 192)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                StepperButton(intValue: $viewModel.weekCount)
                
                if !sheetMode {
                    Text("기간 선택")
                        .font(.bbip(.body1_sb16))
                        .foregroundStyle(.mainWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 12)
                    
                    PeriodPickerButton(
                        viewModel: viewModel,
                        showDatePicker: $showDatePicker
                    )
                }
                
                HStack(spacing: 10) {
                    Text("요일 선택")
                        .font(.bbip(.body1_sb16))
                        .foregroundStyle(.mainWhite)
                    
                    Spacer()
                }
                .padding(.top, 12)
                
                DayPickerView(viewModel: viewModel)
                
                Spacer()
                    .frame(height: 110)
            }
            .padding(.horizontal, 24)
            .sheet(isPresented: $showDatePicker) {
                DatePicker(
                    "setStudyPeriod",
                    selection: $viewModel.startDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .onChange(of: viewModel.startDate) {
                    viewModel.calculateDeadline()
                    showDatePicker = false
                }
                .padding(.top, 20)
                .padding()
                .tint(.primary3)
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(370)])
            }
        }
        .introspect(.scrollView, on: .iOS(.v17)) { scrollView in
            scrollView.showsVerticalScrollIndicator = false
            scrollView.bounces = false
        }
    }
}

private struct StepperButton: View {
    @State private var isFirstInputReceived: Bool = false
    @Binding var intValue: Int
    private let maxValue: Int = 52
    
    private func shootFirstInput() {
        if !isFirstInputReceived {
            isFirstInputReceived = true
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray8)
                .frame(height: 54)
            
            HStack {
                Button {
                    guard intValue > 1 else { return }
                    shootFirstInput()
                    intValue -= 1
                } label: {
                    Image("stepper_minus")
                }
                
                Spacer()
                
                Text("\(intValue) 라운드")
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(isFirstInputReceived ? .mainWhite : .gray5)
                
                Spacer()
                
                Button {
                    guard intValue < maxValue else { return }
                    shootFirstInput()
                    intValue += 1
                } label: {
                    Image("stepper_plus")
                }
            }
        }
    }
}

private struct PeriodPickerButton: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    @Binding var showDatePicker: Bool
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy. MM. dd."
        return formatter.string(from: date)
    }
    
    private var colorBySelected: Color {
        viewModel.deadlineDate != nil
        ? .gray3
        : .gray7
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray8)
                .frame(height: 54)
            
            HStack {
                Spacer()
                
                Button {
                    showDatePicker = true
                } label: {
                    Text(viewModel.periodIsSelected
                         ? formatDate(viewModel.startDate)
                         : "시작일")
                    .font(.bbip(.body1_m16))
                    .foregroundStyle(.gray5)
                    .monospacedDigit()
                }
                
                Spacer()
                
                Image("rightArrow")
                    .renderingMode(.template)
                    .foregroundStyle(colorBySelected)
                
                Spacer()
                
                Text(viewModel.deadlineDate != nil
                     ? formatDate(viewModel.deadlineDate!)
                     : "마감일")
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray7)
                .monospacedDigit()
                
                Spacer()
            }
        }
    }
}

private struct DayPickerView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.selectedDayIndex.indices, id: \.self) { index in
                DayAndTimePickerButton(
                    viewModel: viewModel,
                    dayIndex: $viewModel.selectedDayIndex[index],
                    studySession: $viewModel.selectedDayStudySession[index],
                    indexId: index
                )
            }
            
            addDayButton
                .opacity(viewModel.selectedDayIndex.count < 7 ? 1 : 0)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var addDayButton: some View {
        Button {
            withAnimation { viewModel.createEmptyDay() }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.gray8)
                    .frame(height: 54)
                
                HStack(spacing: 16) {
                    Image("add_plus")
                        .padding(.leading, 22)
                    
                    Text("요일 추가")
                        .font(.bbip(.body1_m16))
                        .foregroundStyle(.gray5)
                    
                    Spacer()
                }
            }
        }
    }
}

private struct DayAndTimePickerButton: View {
    @ObservedObject private var viewModel: CreateStudyViewModel
    @Binding private var dayIndex: Int
    @Binding private var studySession: StudySessionVO
    private let indexId: Int
    
    init(
        viewModel: CreateStudyViewModel,
        dayIndex: Binding<Int>,
        studySession: Binding<StudySessionVO>,
        indexId: Int
    ) {
        self.viewModel = viewModel
        self._dayIndex = dayIndex
        self._studySession = studySession
        self.indexId = indexId
    }
    
    private func formattedTime(for date: Date) -> String {
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "HH:mm"
        return weekdayFormatter.string(from: date)
    }
    
    private let week: [String] = [
        "월", "화", "수", "목", "금", "토", "일"
    ]
    
    private var dayText: String {
        if dayIndex == -1 {
            return "요일 선택"
        } else {
            return week[dayIndex]
        }
    }
    
    private var startTimeText: String {
        if studySession.startTime == nil {
            return "00:00"
        } else {
            return formattedTime(for: studySession.startTime!)
        }
    }
    
    private var endTimeText: String {
        if studySession.endTime == nil {
            return "00:00"
        } else {
            return formattedTime(for: studySession.endTime!)
        }
    }
    
    // 시작 및 종료시간 버튼 가로간격 계산
    private var calcWidth = (UIScreen.main.bounds.width - 54 - 48 - 8 - 50 - 30) / 2
    
    var body: some View {
        HStack(spacing: 8) {
            Button {
                // 요일 선택 sheet
            } label: {
                ZStack {
                   RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.gray8)
                        .frame(width: 90, height: 54)
                    
                    Text(dayText)
                }
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray5)
            }
            
            ZStack {
               RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.gray8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                
                HStack(spacing: 0) {
                    Button {
                        // 시작시간 선택
                    } label: {
                        Text(startTimeText)
                    }
                    .frame(width: calcWidth, height: 30)
                    
                    Text("-")
                    
                    Button {
                        // 종료 시간 선택
                    } label: {
                        Text(endTimeText)
                    }
                    .frame(width: calcWidth, height: 30)
                    
                    Button {
                        withAnimation { viewModel.deleteDay(at: indexId) }
                    } label: {
                        Image("remove_minus")
                    }
                    .padding(.trailing)
                }
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray5)
            }
        }
    }
}



// Not Use (가로형 요일 선택 버튼)
/*
private struct DayPickerButton: View {
    @Binding var selectedDayIndex: [Int]
    private let week: [String] = [
        "월", "화", "수", "목", "금", "토", "일"
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray8)
                .frame(height: 54)
            
            HStack(spacing: 2) {
                ForEach(Array(week.enumerated()), id: \.element) { index, day in
                    Button {
                        if selectedDayIndex.contains(index) {
                            selectedDayIndex.removeAll { $0 == index }
                        } else {
                            selectedDayIndex.append(index)
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(
                                selectedDayIndex.contains(index)
                                ? .primary3
                                : .gray8
                            )
                            .frame(width: 44, height: 44)
                            .overlay {
                                Text(day)
                                    .font(.bbip(.body1_m16))
                                    .foregroundStyle(
                                        selectedDayIndex.contains(index)
                                        ? .mainWhite
                                        : .gray5
                                    )
                            }
                    }
                }
            }
            .padding(.horizontal, 12.5)
            .padding(.vertical, 5)
        }
    }
}
 */

#Preview {
    SISPeriodView(viewModel: .init())
}
