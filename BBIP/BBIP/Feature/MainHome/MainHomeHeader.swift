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
                    
                }
            }
            .frame(height: 44)
            .background(.gray1)
            .frame(maxWidth: .infinity) // Make sure it spans the full width
            
        }
        Spacer()
    }
}

#Preview {
    CustomHeaderView(headerType: .HomeHeader,showDot:true)
    
}

