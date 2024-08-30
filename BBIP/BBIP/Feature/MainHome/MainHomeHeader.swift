//
//  MainHomeHeader.swift
//  BBIP
//
//  Created by 조예린 on 8/29/24.
//

import Foundation
import SwiftUI


enum HeaderType {
    case HomeHeader
    case ElseHeader
}

struct CustomHeaderView: View {
    var headerType: HeaderType = .HomeHeader
    var title: String = "홈"
    var showDot: Bool = false
    
    var body: some View {
        VStack {
            HStack(spacing :0) {
                if headerType == .HomeHeader {
                    Text(title)
                        .font(.bbip(.title3_m20))
                        .foregroundStyle(.mainBlack)
                        .padding(.leading, 20)
                } else if headerType == .ElseHeader {
                    Image("backButton")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 20)
                    
                    Text(title)
                        .font(.bbip(.title3_m20))
                        .foregroundStyle(.gray9)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                
                Spacer()
                
                if headerType == .HomeHeader {
                    HStack(spacing: 24) {
                        Image("notice_icon")
                            .overlay(
                                Group {
                                    if showDot {
                                        Circle()
                                            .fill(.primary3)
                                            .frame(width: 3.5, height: 3.5)
                                            .offset(x: 2, y: -3)
                                    }
                                },
                                alignment: .topTrailing
                            )
                            
                        
                        Image("profile_icon")
                            .padding(.trailing, 28)
                    }
                    
                } else if headerType == .ElseHeader {
                    Image("profile_icon")
                        .padding(.trailing, 28)
                }
            }
            .frame(height: 44)
            .background(Color(UIColor.systemGray6))
            .frame(maxWidth: .infinity) // Make sure it spans the full width
            
        }
        Spacer()
    }
}

#Preview {
    CustomHeaderView(headerType: .ElseHeader, title: "스터디 아카이브")
//    CustomHeaderView(headerType: .HomeHeader, title: "스터디 아카이브",showDot:true)
    
}

