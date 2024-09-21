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
    @State private var showDayPicker: Bool = false
    @State private var showStartTimePicker: Bool = false
    @State private var showEndTimePicker: Bool = false
    
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
                
                StepperButton(
                    viewModel: viewModel
                )
                
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
                    
                    if viewModel.showInvalidTimeAlert {
                        WarningLabel(errorText: "종료 시간이 시작 시간보다 빠릅니다")
                    }
                }
                .padding(.top, 12)
                
                SetDayAndTimeView(
                    viewModel: viewModel,
                    showDayPicker: $showDayPicker,
                    showStartTimePicker: $showStartTimePicker,
                    showEndTimePicker: $showEndTimePicker
                )
                
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
        .scrollIndicators(.never)
        .introspect(.scrollView, on: .iOS(.v17, .v18)) { scrollView in
            scrollView.bounces = false
        }
    }
}

private struct StepperButton: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    private let maxValue: Int = 52
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray8)
                .frame(height: 54)
            
            HStack {
                Button {
                    guard viewModel.weekCount > 1 else { return }
                    viewModel.weekCount -= 1
                } label: {
                    Image("stepper_minus")
                }
                
                Spacer()
                
                Text("\(viewModel.weekCount) 라운드")
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(viewModel.periodIsSelected ? .mainWhite : .gray5)
                
                Spacer()
                
                Button {
                    guard viewModel.weekCount < maxValue else { return }
                    viewModel.weekCount += 1
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
        ? .gray6
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
                    .foregroundStyle(viewModel.periodIsSelected ? .mainWhite : .gray5)
                    .monospacedDigit()
                }
                
                Spacer()
                
                Image("SIS_rightArrow")
                    .renderingMode(.template)
                    .foregroundStyle(colorBySelected)
                
                Spacer()
                
                Text(viewModel.deadlineDate != nil
                     ? formatDate(viewModel.deadlineDate!)
                     : "마감일")
                .font(.bbip(.body1_m16))
                .foregroundStyle(viewModel.periodIsSelected ? .gray6 : .gray7)
                .monospacedDigit()
                
                Spacer()
            }
        }
    }
}

private struct SetDayAndTimeView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    @Binding private var showDayPicker: Bool
    @Binding private var showStartTimePicker: Bool
    @Binding private var showEndTimePicker: Bool
    @State private var selectedIndex: Int? // 선택한 인덱스를 추적
    
    init(
        viewModel: CreateStudyViewModel,
        showDayPicker: Binding<Bool>,
        showStartTimePicker: Binding<Bool>,
        showEndTimePicker: Binding<Bool>
    ) {
        self.viewModel = viewModel
        self._showDayPicker = showDayPicker
        self._showStartTimePicker = showStartTimePicker
        self._showEndTimePicker = showEndTimePicker
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.selectedDayIndex.indices, id: \.self) { index in
                HStack(spacing: 8) {
                    // 요일 선택 버튼
                    Button {
                        selectedIndex = index
                        showDayPicker.toggle() // 요일 선택 picker 열기
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.gray8)
                                .frame(width: 90, height: 54)
                            
                            Text(dayText(for: viewModel.selectedDayIndex[index]))
                                .font(.bbip(.body1_m16))
                                .foregroundStyle(.mainWhite)
                        }
                        .foregroundStyle(.gray5)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.gray8)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                        
                        HStack(spacing: 0) {
                            // 시작 시간 선택 버튼
                            Button {
                                selectedIndex = index
                                showStartTimePicker.toggle() // 시작시간 선택 picker 열기
                            } label: {
                                Text(startTimeText(for: viewModel.selectedDayStudySession[index]))
                                    .foregroundStyle(.mainWhite)
                            }
                            .frame(width: calcWidth, height: 30)
                            
                            Text("-")
                            
                            // 종료 시간 선택 버튼
                            Button {
                                selectedIndex = index
                                showEndTimePicker.toggle() // 종료시간 선택 picker 열기
                            } label: {
                                Text(endTimeText(for: viewModel.selectedDayStudySession[index]))
                                    .foregroundStyle(.mainWhite)
                            }
                            .frame(width: calcWidth, height: 30)
                            
                            // 삭제 버튼
                            Button {
                                withAnimation { viewModel.deleteDay(at: index) }
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
            
            addDayButton
                .opacity(viewModel.selectedDayIndex.count < 7 ? 1 : 0)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $showDayPicker) {
            DayPickerView(
                selectedDay: $viewModel.selectedDayIndex[selectedIndex ?? 0],
                isSheetPresented: $showDayPicker
            )
            .presentationDragIndicator(.visible)
            .presentationDetents([.height(270)])
        }
        .sheet(isPresented: $showStartTimePicker) {
            TimePickerView(
                selectedTime: $viewModel.selectedDayStudySession[selectedIndex ?? 0].startTime,
                isSheetPresented: $showStartTimePicker
            )
            .presentationDragIndicator(.visible)
            .presentationDetents([.height(320)])
        }

        .sheet(isPresented: $showEndTimePicker) {
            TimePickerView(
                selectedTime: $viewModel.selectedDayStudySession[selectedIndex ?? 0].endTime,
                isSheetPresented: $showEndTimePicker
            )
            .presentationDragIndicator(.visible)
            .presentationDetents([.height(320)])
        }
    }
    
    // 요일 선택 텍스트 처리
    private func dayText(for dayIndex: Int) -> String {
        let week = ["월", "화", "수", "목", "금", "토", "일"]
        return dayIndex == -1 ? "요일 선택" : week[dayIndex]
    }
    
    // 시작 시간 텍스트 처리
    private func startTimeText(for studySession: StudySessionVO) -> String {
        guard let startTime = studySession.startTime else { return "00:00" }
        return formattedTime(for: startTime)
    }
    
    // 종료 시간 텍스트 처리
    private func endTimeText(for studySession: StudySessionVO) -> String {
        guard let endTime = studySession.endTime else { return "00:00" }
        return formattedTime(for: endTime)
    }
    
    // 시간 포맷터 HH:mm
    private func formattedTime(for date: Date) -> String {
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "HH:mm"
        return weekdayFormatter.string(from: date)
    }
    
    // 버튼 가로 간격 계산
    private var calcWidth: CGFloat {
        (UIScreen.main.bounds.width - 54 - 48 - 8 - 50 - 30) / 2
    }
    
    // 요일 추가 버튼
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
