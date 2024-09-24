//
//  BBIPTabView.swift
//  BBIP
//
//  Created by 조예린 on 8/28/24.
//

import Foundation
import SwiftUI


enum MainHomeTab {
    case userHome
    case studyHome
    case calendar
}

struct BBIPTabView : View {
    @Binding private var selectedTab: MainHomeTab
    @Binding private var ongoingStudyData: [StudyInfoVO]?
    @State private var showSheet = false
    
    init(
        selectedTab: Binding<MainHomeTab>,
        ongoingStudyData: Binding<[StudyInfoVO]?>
    ) {
        self._selectedTab = selectedTab
        self._ongoingStudyData = ongoingStudyData
    }
    
    private let calw = ((UIScreen.main.bounds.width/2)-33.5-24)/3.905
    private var sheetHeight: CGFloat {
        guard let data = ongoingStudyData else { return 0 }
        return CGFloat(130 + (data.count * 95))
    }
    
    var body: some View {
        ZStack {
            Image("tabbar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)
                .bbipShadow2()
            
            HStack() {
                Button {
                    selectedTab = .userHome
                } label: {
                    Image(selectedTab == .userHome ? "home_active" : "home_nonactive" )
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 1.551*calw)
                        .padding(.trailing, 1.354*calw)
                        .padding(.bottom, 10)
                        .contentShape(Rectangle())
                }
                
                Spacer()
                
                Button {
                    selectedTab = .calendar
                } label: {
                    Image(selectedTab == .calendar ? "calendar_active" : "calendar_nonactive")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 1.551*calw)
                        .padding(.leading, 1.354*calw)
                        .padding(.bottom, 10)
                        .contentShape(Rectangle())
                }
            }
            .overlay {
                Button {
                    showSheet.toggle()
                } label: {
                    Image("switch_button")
                        .frame(width: 67, height: 67)
                        .padding(.bottom, 100)
                }
                .disabled(ongoingStudyData == nil)
            }
            .background(.clear)
        }
        .sheet(isPresented: $showSheet) {
            StudySwitchView(selectedTab: $selectedTab, ongoingStudyData: $ongoingStudyData)
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(sheetHeight)])
        }
    }
}
