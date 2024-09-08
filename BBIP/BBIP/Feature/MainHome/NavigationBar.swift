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


//struct TabContentView : View {
//    @State var selectedTab: Tab = .UserHome
//    var body: some View {
//        VStack{
//            Spacer()
//            switch selectedTab {
//            case .UserHome:
//                Text("You are in UserHomepage.")
//            case .CreateSwitchStudy:
//                Text("You can create and switch study.")
//            case .Calendar:
//                Text("You are in Calendarpage.")
//            }
//            
//            Spacer()
//            CustomTabBarView(selectedTab: $selectedTab)
//        }
//    }
//}


struct CustomTabBarView : View{
    @Binding var selectedTab: Tab
    
    
    var body : some View {
        var calw = ((UIScreen.main.bounds.width/2)-33.5-24)/3.905
        ZStack {
            Image("navigation_bar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -4)
            
            HStack {
                
                
                Button{
                    selectedTab = .UserHome
                }label : {
                    Image(selectedTab == .UserHome ? "home_active" :"home_nonactive" )
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
                }label: {
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


#Preview{
    CustomTabBarView(selectedTab: .constant(.UserHome))
}

