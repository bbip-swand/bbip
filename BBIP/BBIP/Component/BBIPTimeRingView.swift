//
//  BBIPTimeRingView.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import SwiftUI

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
    
    var ddayLabel: String {
        if vo.leftDay == .zero {
            return "TODAY"
        } else {
            return "D-\(vo.leftDay)"
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                let radius = (geometry.size.width - 18 * 2) / 2 // 반지름 계산
                let angle = Angle(degrees: progress * 360 - 90) // 막대 끝 각도 계산
                let xOffset = cos(angle.radians) * radius // X축 위치 계산
                let yOffset = sin(angle.radians) * radius // Y축 위치 계산
                
                ZStack {
                    Circle()
                        .foregroundStyle(.gray8)
                    
                    Group {
                        Circle()
                            .stroke(
                                Color.gray6,
                                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                            )
                        
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                Color.primary3,
                                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.linear, value: progress)
                    }
                    .padding(18)
                    
                    Circle()
                        .foregroundStyle(.primary3)
                        .frame(width: endCircleSize, height: endCircleSize)
                        .offset(x: xOffset, y: yOffset) // 막대의 끝 부분으로 이동
                        .animation(.linear, value: progress) // 애니메이션 적용
                }
                .overlay {
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
                    
                    Image("TimeRingStick")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 30, y: 62)
                }
            }
            
            Button {
                // attendance certification process
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray3)
                    .frame(width: 130, height: 43)
                    .overlay {
                        Text("출석인증")
                            .font(.bbip(.body2_b14))
                            .foregroundStyle(.gray5)
                    }
            }
        }
        .frame(height: 340)
        .padding(.horizontal, 60)
    }
}

#Preview {
    BBIPTimeRingView(
        progress: 0.4,
        vo: ImpendingStudyVO(
            leftDay: 0,
            title: "TOEIC / IELTS",
            time: "18:00 - 20:00",
            location: "예대 4층")
    )
}
