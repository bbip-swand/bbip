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
            
            Spacer()
            
            MainButton(text: "파이트!") {
                // Request check attendance code
            }
            .padding(.bottom, 22)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray9)
        .backButtonStyle(isReversal: true)
    }
}

#Preview {
    AttendanceCertificationView(remainingTime: 0)
}
