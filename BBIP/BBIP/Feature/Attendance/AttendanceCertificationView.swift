//
//  AttendanceCertificationView.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI
import Combine

struct AttendanceCertificationView: View {
    @ObservedObject private var viewModel: AttendanceCertificationViewModel = .init()
    @FocusState private var focusedIndex: Int?
    
    @State private var timer: AnyCancellable?
    @State private var formattedTime: String = "00:00"
    @State private var remainingTime: Int
    var studyName: String = "StudyName"
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        formattedTime = formatTime(remainingTime)
        
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                guard remainingTime > 0 else {
                    timer?.cancel()
                    return
                }
                remainingTime -= 1
                formattedTime = formatTime(remainingTime)
            }
    }
    
    init(remainingTime: Int) {
        self.remainingTime = remainingTime
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            Image("glove")
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.top, remainingTime == 0 ? 22 : 50)
                .padding(.bottom, remainingTime == 0 ? 12 : 20)
            
            Text("출석 인증 코드 입력")
                .foregroundStyle(.mainWhite)
                .font(.bbip(.title4_sb24))
                .padding(.bottom, 12)
            
            Text("생성된 4자리 코드를 입력하세요")
                .foregroundStyle(.gray6)
                .font(.bbip(.caption1_m16))
                .padding(.bottom, remainingTime == 0 ? 41 : 48)
            
            if remainingTime == 0 {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.gray8)
                    
                    
                    Text(studyName)
                        .font(.bbip(.title3_sb20))
                        .foregroundColor(.mainWhite)
                }
                .frame(maxWidth: .infinity, maxHeight: 34)
                .padding(.horizontal, 38)
                .padding(.bottom, 8)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray8)
                    .padding(.horizontal, 38)
                
                HStack(spacing: 15) {
                    Image("alarm")
                        .renderingMode(.template)
                        .foregroundColor(remainingTime == 0 ? .primary3 : .mainWhite)
                    
                    Text(formattedTime)
                        .font(.bbip(.title1_sb42))
                        .foregroundStyle(remainingTime == 0 ? .primary3 : .mainWhite)
                        .onAppear {
                            startTimer()
                        }
                }
            }
            
            if remainingTime != 0 {
                HStack(spacing: 12) {
                    Spacer(minLength: 38)
                    ForEach(0..<4, id: \.self) { index in
                        CustomTextFieldComponent(
                            text: $viewModel.codeDigits[index],
                            isRight: $viewModel.isRight,
                            focusedField: $focusedIndex,
                            index: index,
                            font: .bbip(.title1_sb42),
                            viewModel: viewModel
                        )
                        .customFieldStyle(
                            isFocused: focusedIndex == index,
                            isRight: viewModel.isRight,
                            isComplete: viewModel.isComplete(),
                            isFilled: !viewModel.codeDigits[index].isEmpty
                        )
                    }
                    Spacer(minLength: 39)
                }
                .padding(.top, 20)
                
                createWarningLabel()
            }
            
            
            Spacer()
            
            if remainingTime == 0 {
                Text("라운드가 이미 시작되었습니다.")
                    .font(.bbip(family: .Medium, size:16))
                    .foregroundStyle(.gray6)
                    .padding(.bottom,20)
            }
            
            
            
            MainButton(text: "파이트!") {
                // TODO: Request check attendance code & check the time
            }
            .padding(.bottom, 22)
            
        }
        .backButtonStyle(isReversal: true)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray9)
        .onAppear {
            focusedIndex = viewModel.isComplete() ? 3 : 0
        }
        .contentShape(Rectangle())
        .onTapGesture {
            focusedIndex = nil
        }
    }
    
    
    
    private func createWarningLabel() -> some View {
        HStack(spacing: 6) {
            if viewModel.isComplete() && !viewModel.isRight {
                WarningLabel(errorText: "코드가 올바르지 않습니다.")
            }
        }
        .foregroundStyle(.primary3)
        .frame(maxWidth: .infinity)
        .frame(height: 23)
        .padding(.top, 23)
    }
    
    
    
    
}

fileprivate extension View {
    func customFieldStyle(isFocused: Bool, isRight: Bool, isComplete: Bool, isFilled: Bool) -> some View {
        self
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        (isComplete && !isRight) || isFocused || isFilled ? .primary3 : Color.clear,
                        lineWidth: 2
                    )
            )
    }
}

#Preview {
    AttendanceCertificationView(remainingTime: 10)
}
