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
                .padding(.top, 50)
                .padding(.bottom, 20)
            
            Text("출석 인증 코드 입력")
                .foregroundStyle(.mainWhite)
                .font(.bbip(.title4_sb24))
                .padding(.bottom, 12)
            
            Text("생성된 4자리 코드를 입력하세요")
                .foregroundStyle(.gray6)
                .font(.bbip(.caption1_m16))
                .padding(.bottom, 48)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray8)
                    .padding(.horizontal, 38)
                
                HStack(spacing: 15) {
                    Image("alarm")
                    
                    Text(formattedTime)
                        .font(.bbip(.title1_sb42))
                        .foregroundStyle(.mainWhite)
                        .onAppear {
                            startTimer()
                        }
                }
            }
            
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
            
            Spacer()
            
            MainButton(text: "파이트!") {
                // Request check attendance code
            }
            .padding(.bottom, 22)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray9)
        .backButtonStyle(isReversal: true)
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
    AttendanceCertificationView(remainingTime: 0)
}
