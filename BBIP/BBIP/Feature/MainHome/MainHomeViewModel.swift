//
//  MainHomeViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import Foundation

class MainHomeViewModel: ObservableObject {
    @Published var homeBulletnData = HomeBulletnboardPostVO.generateMock()
    @Published var currentWeekStudyData = CurrentWeekStudyInfoVO.generateMock()
    @Published var commingScheduleData = CommingScheduleVO.generateMock()
}
