//
//  AddScheduleView.swift
//  BBIP
//
//  Created by 이건우 on 11/14/24.
//

import SwiftUI

struct AddScheduleView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddScheculeViewModel = DIContainer.shared.makeAddScheduleViewModel()
    
    @State private var showStartDatePicker: Bool = false
    @State private var showEndDatePicker: Bool = false
    @State private var showStartTimePicker: Bool = false
    @State private var showEndTimePicker: Bool = false
    
    private var ongoingStudyData: [StudyInfoVO]?
    
    init(ongoingStudyData: [StudyInfoVO]? = nil) {
        self.ongoingStudyData = ongoingStudyData?.filter{ $0.isManager }
    }
    
    private func formattedDate(for date: Date) -> String {
        return DateFormatter.customFormatter(format: "yyyy.MM.dd").string(from: date)
    }
    
    private func formattedTime(for date: Date) -> String {
        return DateFormatter.customFormatter(format: "HH:mm").string(from: date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            Spacer().frame(height: 22)
            
            selectStudy
            Spacer().frame(height: 8)
            
            schduleTitle
            
            Spacer().frame(height: 32)
            
            selectTime
            Spacer().frame(height: 32)
            
            toggleIcon
            Spacer().frame(height: 8)
            if viewModel.showHome {
                selectIcon
            }
            
            Spacer()
        }
        .keyboardHideable()
        .padding(.horizontal, 16)
        .background(.gray1)
        .navigationBarBackButtonHidden()
    }
}

extension AddScheduleView {
    // MARK: - Header
    var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("취소")
                    .font(.bbip(.button2_m16))
                    .foregroundStyle(.gray5)
                    .padding(.leading, 14)
            }
            
            Spacer()
            
            Button {
                viewModel.addSchedule()
                dismiss()
            } label: {
                Text("완료")
                    .font(.bbip(.button2_m16))
                    .foregroundStyle(viewModel.canAddSchedule ? .primary3 : .gray5)
                    .disabled(!viewModel.canAddSchedule)
                    .padding(.trailing, 14)
            }
        }
        .frame(height: 42)
    }
    
    // MARK: - Select study
    var selectStudy: some View {
        Group {
            if let ongoingStudyData = ongoingStudyData {
                if ongoingStudyData.isEmpty {
                    emptyStudyView
                } else {
                    studyMenu(ongoingStudyData: ongoingStudyData)
                }
            } else {
                EmptyView()
            }
        }
    }
    
    // Subview for the "Empty Study" state
    private var emptyStudyView: some View {
        HStack(spacing: 10) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 145, height: 41)
                    .foregroundStyle(.mainWhite)
                    .bbipShadow1()
                
                Text("스터디 선택")
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(.gray5)
                    .padding(.leading, 14)
            }
            .disabled(true)
            
            Text("진행 중인 스터디가 없습니다.")
                .font(.bbip(.body2_m14))
                .foregroundStyle(.gray5)
        }
    }
    
    // Subview for the "Menu" state
    private func studyMenu(ongoingStudyData: [StudyInfoVO]) -> some View {
        Menu {
            ForEach(ongoingStudyData.indices, id: \.self) { index in
                Button {
                    viewModel.selectedStudyName = ongoingStudyData[index].studyName
                    viewModel.selectedStudyId = ongoingStudyData[index].studyId
                } label: {
                    Text(ongoingStudyData[index].studyName)
                }
            }
        } label: {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 41)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.mainWhite)
                    .bbipShadow1()
                
                Text(viewModel.selectedStudyName ?? "스터디 선택")
                    .font(.bbip(.body2_m14))
                    .foregroundStyle(viewModel.selectedStudyName == nil ? .gray5 : .mainBlack)
                    .padding(.leading, 14)
            }
        }
    }
    
    // MARK: - Schedule title
    var schduleTitle: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .bbipShadow1()
                .frame(height: 41)
                .frame(maxWidth: .infinity)
            
            TextField(
                "",
                text: $viewModel.scheduleTitle,
                prompt: Text("제목 입력").foregroundColor(.gray5)
            )
            .padding(.horizontal, 14)
            .font(.bbip(.body2_m14))
            .foregroundColor(.mainBlack)
        }
    }
    
    var selectTime: some View {
        VStack(spacing: 8) {
            dateTimeRow(
                title: "시작일",
                date: $viewModel.startDate,
                time: $viewModel.startTime,
                showDatePicker: $showStartDatePicker,
                showTimePicker: $showStartTimePicker
            )
            
            dateTimeRow(
                title: "종료일",
                date: $viewModel.endDate,
                time: $viewModel.endTime,
                showDatePicker: $showEndDatePicker,
                showTimePicker: $showEndTimePicker
            )
        }
    }
    
    // Reusable row for date and time selection
    private func dateTimeRow(
        title: String,
        date: Binding<Date?>,
        time: Binding<Date?>,
        showDatePicker: Binding<Bool>,
        showTimePicker: Binding<Bool>
    ) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 41)
                .frame(maxWidth: .infinity)
                .foregroundColor(.mainWhite)
            
            HStack(spacing: 0) {
                Text(title)
                    .font(.bbip(.body2_m14))
                    .foregroundColor(.mainBlack)
                    .padding(.leading, 16)
                
                Spacer()
                
                // Date selection button
                selectionButton(
                    text: date.wrappedValue.map { formattedDate(for: $0) } ?? title,
                    placeholderColor: .gray5,
                    valueColor: .mainBlack,
                    showPicker: showDatePicker,
                    width: 105
                )
                .sheet(isPresented: showDatePicker) {
                    DatePicker(
                        "setSchedulePeriod",
                        selection: Binding(
                            get: { date.wrappedValue ?? Date() },
                            set: { newValue in
                                date.wrappedValue = newValue
                            }
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .onChange(of: date.wrappedValue) {
                        showDatePicker.wrappedValue = false
                    }
                    .padding(.top, 20)
                    .padding()
                    .tint(.primary3)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(370)])
                }
                
                // Time selection button
                selectionButton(
                    text: time.wrappedValue.map { formattedTime(for: $0) } ?? "시간",
                    placeholderColor: .gray5,
                    valueColor: .mainBlack,
                    showPicker: showTimePicker,
                    width: 75
                )
                .sheet(isPresented: showTimePicker) {
                    TimePickerView(
                        selectedTime: time,
                        isSheetPresented: showTimePicker
                    )
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(320)])
                }
                .padding(.leading, 8)
                .padding(.trailing, 16)
            }
        }
    }
    
    // Generic selection button for date or time
    private func selectionButton(
        text: String,
        placeholderColor: Color,
        valueColor: Color,
        showPicker: Binding<Bool>,
        width: CGFloat
    ) -> some View {
        Button(action: {
            showPicker.wrappedValue.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray2)
                    .frame(width: width, height: 31)
                
                Text(text)
                    .font(.bbip(.body2_m14))
                    .foregroundColor(text == "시작일" || text == "종료일" || text == "시간" ? placeholderColor : valueColor)
                    .padding(.horizontal, 16)
            }
        }
    }
    
    // MARK: - Select icon
    var toggleIcon: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .bbipShadow1()
                .frame(height: 41)
                .frame(maxWidth: .infinity)
            
            HStack {
                Text("홈에서 보기")
                    .padding(.horizontal, 14)
                    .font(.bbip(.body2_m14))
                    .foregroundColor(.mainBlack)
                
                Spacer()
                
                Toggle(isOn: $viewModel.showHome) {}
                    .tint(.primary3)
                    .padding(.trailing, 5)
                    .scaleEffect(0.9)
            }
        }
    }
    
    var selectIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.mainWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 142)
            
            HStack(alignment: .top, spacing: 0) {
                Text("아이콘")
                    .font(.bbip(.body2_m14))
                    .foregroundColor(.mainBlack)
                    .padding(.leading, 14)
                
                Spacer()
                
                VStack(spacing: 12) {
                    iconRow(startIndex: 1, endIndex: 4)
                    iconRow(startIndex: 5, endIndex: 8)
                }
                .padding([.trailing, .leading], 13)
            }
            .padding(.vertical, 12)
        }
        .bbipShadow1()
    }
    
    private func iconRow(startIndex: Int, endIndex: Int) -> some View {
        HStack(spacing: 12) {
            ForEach(startIndex...endIndex, id: \.self) { index in
                iconButton(index: index)
            }
        }
    }
    
    private func iconButton(index: Int) -> some View {
        Button {
            viewModel.iconType = index
        } label: {
            Image("dday_icon\(index)")
                .resizable()
                .frame(width: 53, height: 53)
                .overlay(
                    Circle()
                        .stroke(.primary3, lineWidth: viewModel.iconType == index ? 1.5 : 0)
                )
        }
    }
}
