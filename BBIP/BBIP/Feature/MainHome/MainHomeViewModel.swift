//
//  MainHomeViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import Foundation
import Combine

class MainHomeViewModel: ObservableObject {
    
    // mock data for test
    @Published var commingScheduleData = CommingScheduleVO.generateMock()
    
    // real data
    @Published var homeBulletnData: RecentPostVO?
    @Published var currentWeekStudyData: CurrentWeekStudyInfoVO?
    
    // 게시판 글 불러오기
    private let getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol
    private let getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol,
        getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.getCurrentWeekPostUseCase = getCurrentWeekPostUseCase
        self.getCurrentWeekStudyInfoUseCase = getCurrentWeekStudyInfoUseCase
        self.cancellables = cancellables
    }
    
    private func clearData() {
        homeBulletnData = nil
        currentWeekStudyData = nil
    }
    
    func loadHomeData() {
        getCurrentWeekPostUseCase.excute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("fail load home bulletn: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.homeBulletnData = response
            }
            .store(in: &cancellables)
        
        getCurrentWeekStudyInfoUseCase.excute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("failed load current week study: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.currentWeekStudyData = response
            }
            .store(in: &cancellables)
    }
    
    func refreshHomeData() {
        clearData()
        
        // for testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadHomeData()
        }
    }
}
