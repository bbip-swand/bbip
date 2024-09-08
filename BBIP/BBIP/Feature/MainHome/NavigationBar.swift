//
//  NavigationBar.swift
//  BBIP
//
//  Created by 조예린 on 8/28/24.
//

import Foundation
import SwiftUI


enum Tab{
    case UserHome
    case CreateSwitchStudy
    case Calendar
}


struct TabContentView : View {
    @State var selectedTab: Tab = .UserHome
    var body: some View {
        VStack{
            Spacer()
            switch selectedTab {
            case .UserHome:
                Text("You are in UserHomepage.")
            case .CreateSwitchStudy:
                Text("You can create and switch study.")
            case .Calendar:
                Text("You are in Calendarpage.")
            }
            
            Spacer()
            CustomTabBarView(selectedTab: $selectedTab)
        }
    }
}


struct CustomTabBarView : View{
    @Binding var selectedTab: Tab
    var body : some View{
        ZStack {
            Image("navigation_bar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -4)
            HStack {
                Spacer().frame(width: 55.2)
                
                Button(){
                    selectedTab = .UserHome
                }label : {
                    Image(selectedTab == .UserHome ? "home_active" :"home_nonactive" )
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Button {
                    selectedTab = .Calendar
                }label: {
                    Image(selectedTab == .Calendar ? "calendar_active" : "calendar_nonactive")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                Spacer().frame(width:55.2)
                
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
        .frame(maxHeight: .infinity, alignment: .bottom)
        .background(.gray1)
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview{
    TabContentView()
}

