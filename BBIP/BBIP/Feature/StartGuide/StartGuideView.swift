//
//  StartGuideView.swift
//  BBIP
//
//  Created by 이건우 on 10/2/24.
//

import SwiftUI

struct StartGuideView: View {
    @State private var showCreateStudyView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 92)
            
            Group {
                Text("팀장 또는 팀원으로 시작해보세요!")
                    .font(.bbip(.title4_sb24))
                    .padding(.bottom, 10)
                
                Text("참여할 방법을 선택하세요")
                    .font(.bbip(.caption1_m16))
                    .foregroundStyle(.gray6)
            }
            .padding(.horizontal, 20)
            
            Image("startGuide_member")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .bbipShadow1()
                .padding(.vertical, 22)
                .padding(.horizontal, 20)
            
            Image("startGuide_manager")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .bbipShadow1()
                .padding(.horizontal, 20)
                .overlay(alignment: .bottom) {
                    Button {
                        
                    } label: {
                        Text("생성하기")
                            .font(.bbip(.button1_m20))
                            .foregroundColor(.mainWhite)
                            .frame(width: UIScreen.main.bounds.width - 72, height: 50)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.primary3))
                    }
                    .padding(.bottom, 17)
                }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray1)
        .navigationDestination(isPresented: $showCreateStudyView) {
            StartCreateStudyView()
        }
    }
}

#Preview {
    StartGuideView()
}
