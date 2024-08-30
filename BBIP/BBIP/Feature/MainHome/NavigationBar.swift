//
//  NavigationBar.swift
//  BBIP
//
//  Created by 조예린 on 8/28/24.
//

import Foundation
import SwiftUI

struct CustomNavigationBar: View {
    typealias Action = () -> Void
    
    var onHomeTapped: Action
    var onCalendarTapped: Action
    var onSwitchTapped: Action
    
    var body: some View {
        Image("navigation_bar")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -4)
            .overlay(
                HStack(spacing: 70) { // 버튼 간격 설정
                    Button(action: onHomeTapped) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.clear)
                                .frame(width: 60, height: 60)
                            
                            Image("navigation_home")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                    Button(action: onSwitchTapped) {
                        Image("switch_button")
                            .resizable()
                            .frame(width: 67, height: 67)
                            .padding(.bottom, 80)
                    }
                    
                    Button(action: onCalendarTapped) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.clear)
                                .frame(width: 60, height: 60)
                            
                            Image("navigation_calendar")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                }
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .background(.gray1)
            .edgesIgnoringSafeArea(.bottom)
    }
}


struct BarView: View {
    var body: some View {
        CustomNavigationBar(
            onHomeTapped: {
                print("Home button tapped")
            },
            onCalendarTapped: {
                print("Calendar button tapped")
            },
            onSwitchTapped: {
                print("Switch button tapped")
            }
        )
    }
}


#Preview{
    BarView()
}

