//
//  HomeView.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import SwiftUI

struct MainHomeView: View {
    @State private var progress: Double = 0.1
    
    var body: some View {
        
        NavigationStack {
            NavigationLink {
                StartCreateStudyView()
            } label: {
                Text("Go to Create Study")
                    .font(.bbip(.title4_sb24))
            }
        }
        
        /*
        VStack(spacing: 0) {
            Spacer()
            ZStack {
                CircularProgressView(progress: progress)
                    .frame(width: 250, height: 250)
                
                VStack(spacing: 10) {
                    Text("오늘 스터디")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text("TOPIC / IELTS")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("18:00-20:00\n예대 4층")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.vertical, 35)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.gray)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1.5)) {
                progress = Double.random(in: 0...1)
            }
        }
         */
    }
}


import SwiftUI

struct CircularProgressView: View {
    var progress: Double
    var lineWidth: CGFloat = 10.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.white.opacity(0.2),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.yellow,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
        }
    }
}


#Preview {
    MainHomeView()
}
