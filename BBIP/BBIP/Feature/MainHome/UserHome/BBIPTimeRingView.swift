//
//  BBIPTimeRingView.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import SwiftUI
import Combine

struct BBIPTimeRingView: View {
    private var progress: Double
    private var isAttended: Bool
    private var vo: PendingStudyVO
    
    private var lineWidth: CGFloat = 8
    private var endCircleSize: CGFloat = 18
    
    init(vo: PendingStudyVO, isAttended: Bool = false) {
        self.vo = vo
        self.isAttended = isAttended
        self.progress = vo.totalWeeks > 0 ? Double(vo.studyWeek) / Double(vo.totalWeeks) : 0
    }
    
    private var ddayLabel: String {
        vo.leftDays == .zero ? "TODAY" : "D-\(vo.leftDays)"
    }
    
    private var contentBody: some View {
        VStack(spacing: 0) {
            CapsuleView(title: ddayLabel, type: .timeRing)
                .padding(.bottom, 20)
            
            Text(vo.studyName)
                .font(.bbip(.title4_sb24))
                .foregroundStyle(.mainWhite)
                .padding(.bottom, 12)
            
            Group {
                Text(vo.studyTime)
                    .padding(.bottom, 2)
                
                Text(vo.place)
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
                        .unredacted()
                }
            }
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.gray3)
                .frame(width: 130, height: 43)
                .overlay {
                    Text(isAttended ? "출석완료" : "출석인증")
                        .font(.bbip(.body2_b14))
                        .foregroundStyle(.gray5)
                }
        }
        .frame(height: (UIScreen.main.bounds.width - 120) + 43 + 24)
        .padding(.horizontal, 60)
    }
}

struct ActivatedBBIPTimeRingView: View {
    @EnvironmentObject var appState: AppStateManager
    @State private var progress: Double = 0
    @State private var remainingTime: Int
    @State private var formattedTime: String = "00:00"
    @State private var timer: AnyCancellable?
    @State private var showCircle: Bool = false
    
    @State private var showAttendanceRecordView: Bool = false
    
    private let initialTime: Int = 60 * 10 // 출결 제한시간은 10분
    private var lineWidth: CGFloat = 8
    private var endCircleSize: CGFloat = 18
    private var completion: (() -> Void)?
    private var attendanceStatus: AttendanceStatusVO
    
    init(
        vo: AttendanceStatusVO,
        completion: (() -> Void)? = nil
    ) {
        self.attendanceStatus = vo
        self.remainingTime = vo.remainingTime
        self.completion = completion
    }
    
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
                    completion?()
                    return
                }
                remainingTime -= 1
                progress = Double(remainingTime) / Double(initialTime)
                formattedTime = formatTime(remainingTime)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
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
                            .animation(.easeInOut(duration: 0.2), value: progress)
                    }
                    .padding(18)
                    
                    Circle()
                        .foregroundStyle(.mainWhite)
                        .frame(width: endCircleSize, height: endCircleSize)
                        .offset(x: xOffset, y: yOffset)
                        .opacity(showCircle ? 1 : 0)
                        .animation(.linear, value: showCircle)
                }
                .overlay {
                    VStack(spacing: 5) {
                        Text(attendanceStatus.studyName)
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
                    .offset(x: 30, y: 62)
                    .unredacted()
            }
            
            Button {
                timer?.cancel()
                if attendanceStatus.isManager {
                    showAttendanceRecordView = true
                } else {
                    appState.push(
                        .entercode(
                            remainingTime: attendanceStatus.remainingTime,
                            studyId: attendanceStatus.studyId,
                            studyName: attendanceStatus.studyName
                        )
                    )
                }
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
        .frame(height: (UIScreen.main.bounds.width - 120) + 43 + 24)
        .padding(.horizontal, 60)
        .navigationDestination(isPresented: $showAttendanceRecordView) {
            AttendanceRecordView(remainingTime: remainingTime, studyId: attendanceStatus.studyId, code: attendanceStatus.code)
        }
    }
}
