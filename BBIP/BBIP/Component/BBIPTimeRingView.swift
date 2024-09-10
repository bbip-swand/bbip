//
//  BBIPTimeRingView.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import SwiftUI
import Combine

struct BBIPTimeRingView: View {
    @State private var progress: Double
    private var vo: ImpendingStudyVO
    
    private var lineWidth: CGFloat = 8
    private var endCircleSize: CGFloat = 18
    
    init(
        progress: Double,
        vo: ImpendingStudyVO
    ) {
        self.progress = progress
        self.vo = vo
    }
    
    private var ddayLabel: String {
        vo.leftDay == .zero ? "TODAY" : "D-\(vo.leftDay)"
    }
    
    private var contentBody: some View {
        VStack(spacing: 0) {
            CapsuleView(title: ddayLabel, type: .timeRing)
                .padding(.bottom, 20)
            
            Text(vo.title)
                .font(.bbip(.title4_sb24))
                .foregroundStyle(.mainWhite)
                .padding(.bottom, 12)
            
            Group {
                Text(vo.time)
                    .padding(.bottom, 2)
                
                Text(vo.location ?? "장소 미정")
            }
            .font(.bbip(.body2_m14))
            .foregroundStyle(.gray5)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                let radius = (geometry.size.width - 18 * 2) / 2
                let angle = Angle(degrees: progress * 360 - 90)
                let xOffset = cos(angle.radians) * radius
                let yOffset = sin(angle.radians) * radius
                
                ZStack {
                    Circle()
                        .foregroundStyle(.gray8)
                    
                    Group {
                        Circle()
                            .stroke(
                                .gray6,
                                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                            )
                        
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                .primary3,
                                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.linear, value: progress)
                    }
                    .padding(18)
                    
                    Circle()
                        .foregroundStyle(.primary3)
                        .frame(width: endCircleSize, height: endCircleSize)
                        .offset(x: xOffset, y: yOffset)
                        .animation(.easeIn, value: progress)
                }
                .overlay {
                    contentBody
                    
                    Image("timeRingStick_disable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 30, y: 62)
                }
            }
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.gray3)
                .frame(width: 130, height: 43)
                .overlay {
                    Text("출석인증")
                        .font(.bbip(.body2_b14))
                        .foregroundStyle(.gray5)
                }
        }
        .frame(height: 340)
        .padding(.horizontal, 60)
    }
}

struct AttendanceCertificationView: View {
    @State private var progress: Double = 0
    @State private var remainingTime: Int
    @State private var formattedTime: String = "00:00"
    @State private var timer: AnyCancellable?
    @State private var showCircle: Bool = false
    @State private var shakeStick: Bool = false
    
    private let initialTime: Int = 60 // for test
    private var studyTitle: String
    private var lineWidth: CGFloat = 8
    private var endCircleSize: CGFloat = 18
    
    init(
        studyTitle: String,
        remainingTime: Int
    ) {
        self.studyTitle = studyTitle
        self.remainingTime = remainingTime
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                guard remainingTime > 0 else {
                    timer?.cancel()
                    return
                }
                remainingTime -= 1
                progress = Double(remainingTime) / Double(initialTime)
                formattedTime = formatTime(remainingTime)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                     if !showCircle { showCircle = true }
                }
            }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                let radius = (geometry.size.width - 18 * 2) / 2
                let angle = Angle(degrees: progress * 360 - 90)
                let xOffset = cos(angle.radians) * radius
                let yOffset = sin(angle.radians) * radius
                
                ZStack {
                    Circle()
                        .foregroundStyle(.primary3)
                    
                    Group {
                        Circle()
                            .stroke(
                                .primary2,
                                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                            )
                        
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                .mainWhite,
                                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut(duration: 0.25), value: progress)
                    }
                    .padding(18)
                    
                    Circle()
                        .foregroundStyle(.mainWhite)
                        .frame(width: endCircleSize, height: endCircleSize)
                        .offset(x: xOffset, y: yOffset)
                        .opacity(showCircle ? 1 : 0)
                        .animation(.linear, value: showCircle)
                        .animation(.easeInOut, value: progress)
                }
                .overlay {
                    VStack(spacing: 5) {
                        Text(studyTitle)
                            .font(.bbip(.title3_m20))
                            .foregroundStyle(.mainWhite)
                        
                        Text(formattedTime)
                            .font(.bbip(.title1_sb42))
                            .foregroundStyle(.mainWhite)
                            .onAppear {
                                startTimer()
                            }
                    }
                }
                Image("timeRingStick_enable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: 30, y: 68)
            }
            Button {
                // attendance certification process
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.primary3)
                    .frame(width: 130, height: 43)
                    .overlay {
                        Text("출석인증")
                            .font(.bbip(.body2_b14))
                            .foregroundStyle(.mainWhite)
                    }
            }
            .buttonStyle(PlainButtonStyle())
            .background( // hide stick image
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.mainWhite)
                    .frame(width: 130, height: 43)
            )
        }
        .frame(height: 340)
        .padding(.horizontal, 60)
    }
}

#Preview {
    
    VStack(spacing: 40) {
        BBIPTimeRingView(
            progress: 0.4,
            vo: ImpendingStudyVO(
                leftDay: 0,
                title: "TOEIC / IELTS",
                time: "18:00 - 20:00",
                location: "예대 4층")
        )
        
        AttendanceCertificationView(
            studyTitle: "TOEIC / IELTS",
            remainingTime: 40
        )
    }
    
}
