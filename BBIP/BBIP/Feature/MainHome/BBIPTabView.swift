//
//  BBIPTabView.swift
//  BBIP
//
//  Created by 조예린 on 8/28/24.
//

import Foundation
import SwiftUI


enum Tab {
    case UserHome
    case CreateSwitchStudy
    case Calendar
}

struct BBIPTabView : View {
    @Binding var selectedTab: Tab
    private let calw = ((UIScreen.main.bounds.width/2)-33.5-24)/3.905
    
    var body: some View {
        ZStack {
            Image("navigation_bar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -4)
            
            HStack {
                Button {
                    selectedTab = .UserHome
                } label: {
                    Image(selectedTab == .UserHome ? "home_active" : "home_nonactive" )
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 1.551*calw)
                        .padding(.trailing, 1.354*calw)
                        .padding(.top,9)
                        .padding(.bottom,5)
                        .contentShape(Rectangle())
                }
                
                Spacer()
                
                Button {
                    selectedTab = .Calendar
                } label: {
                    Image(selectedTab == .Calendar ? "calendar_active" : "calendar_nonactive")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 1.551*calw)
                        .padding(.leading, 1.354*calw)
                        .padding(.top,9)
                        .padding(.bottom,5)
                        .contentShape(Rectangle())
                }
            }
            .overlay {
                Button {
                    selectedTab = .CreateSwitchStudy
                } label: {
                    Image("switch_button")
                        .frame(width: 67, height: 67)
                        .padding(.bottom, 80)
                }
            }
        }
    }
}
