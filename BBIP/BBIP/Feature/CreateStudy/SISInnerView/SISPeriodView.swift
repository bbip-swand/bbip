//
//  SISPeriodView.swift
//  BBIP
//
//  Created by 이건우 on 8/31/24.
//

import SwiftUI

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
                
                Text("선택 안함")
                    .font(.bbip(.caption3_r12))
                    .foregroundStyle(.gray5)
                
                Button {
                    viewModel.skipDaySelection.toggle()
                    if viewModel.skipDaySelection {
                        viewModel.selectedDayIndex.removeAll()
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 18, height: 18)
                        .foregroundStyle(viewModel.skipDaySelection ? .primary2.opacity(0.5) : .gray8)
                        .radiusBorder(cornerRadius: 4, color: viewModel.skipDaySelection ? .primary3 : .gray3)
                        .overlay {
                            if viewModel.skipDaySelection {
                                Image("check")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(.primary3)
                                    .frame(width: 12, height: 12)
                            }
                        }
                }
            }
            .padding(.top, 12)
            
            DayPickerButton(selectedDayIndex: $viewModel.selectedDayIndex)
            
            Spacer()
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
}

private struct StepperButton: View {
    @Binding var intValue: Int
    private let maxValue: Int = 52
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray8)
                .frame(height: 54)
                .radiusBorder(cornerRadius: 12, color: .gray6)
            
            HStack {
                Button {
                    guard intValue > 1 else { return }
                    intValue -= 1
                } label: {
                    Image("stepper_minus")
                }
                
                Spacer()
                
                Text("\(intValue) 라운드")
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.mainWhite)
                
                Spacer()
                
                Button {
                    guard intValue < maxValue else { return }
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
                .radiusBorder(cornerRadius: 12, color: .gray6)
            
            HStack {
                Spacer()
                
                Button {
                    showDatePicker = true
                } label: {
                    Text(viewModel.periodIsSelected
                         ? formatDate(viewModel.startDate)
                         : "시작일")
                    .font(.bbip(.body1_m16))
                    .foregroundStyle(.gray3)
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
                .radiusBorder(cornerRadius: 12, color: .gray6)
            
            HStack(spacing: 4) {
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
