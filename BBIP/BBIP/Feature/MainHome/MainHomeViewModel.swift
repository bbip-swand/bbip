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
    
    //remainingTime
    @Published var remainingTime:Int = 600
    
    // real data
    @Published var homeBulletnData: RecentPostVO?
    @Published var currentWeekStudyData: [CurrentWeekStudyInfoVO]?
    @Published var ongoingStudyData: [StudyInfoVO]?
    @Published var getStatusData: GetStatusVO?
    
    // UseCases
    private let getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol            // 게시글
    private let getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol  // 이번 주 스터디
    private let getOngoingStudyInfoUseCase: GetOngoingStudyInfoUseCaseProtocol          // 진행중인 스터디
    private var cancellables = Set<AnyCancellable>()
    private let getStatusUseCase: GetStatusUseCaseProtocol
    
    init(
        getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol,
        getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol,
        getOngoingStudyInfoUseCase: GetOngoingStudyInfoUseCaseProtocol,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        getStatusUseCase: GetStatusUseCaseProtocol
    ) {
        self.getCurrentWeekPostUseCase = getCurrentWeekPostUseCase
        self.getCurrentWeekStudyInfoUseCase = getCurrentWeekStudyInfoUseCase
        self.getOngoingStudyInfoUseCase = getOngoingStudyInfoUseCase
        self.cancellables = cancellables
        self.getStatusUseCase = getStatusUseCase
    }
    
    private func clearData() {
        homeBulletnData = nil
        currentWeekStudyData = nil
    }
    
    //TODO: 시간 계산을 여기서 하는 게 맞을까?
    func getStatusAttend() {
        getStatusUseCase.execute()
                .receive(on: DispatchQueue.main) // UI 업데이트를 위해 메인 스레드에서 받음
                .sink{completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        error.handleDecodingError()
                        print("fail load attend status: \(error.localizedDescription)")
                    }
                }receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.getStatusData = response 
                    print("GetStatusData: ")
                    print(getStatusData)// 받은 상태 정보를 저장
                    // remainingTime 계산
                    let currentTime = Date()
                    let expirationTime = response.startTime.addingTimeInterval(TimeInterval(response.ttl))
                    self.remainingTime = max(0, Int(expirationTime.timeIntervalSince(currentTime)))
                }
                .store(in: &cancellables)

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
        
        getOngoingStudyInfoUseCase.excute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("failed load ongoing study: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.ongoingStudyData = response
            }
            .store(in: &cancellables)
    }
    
    func refreshHomeData() {
        clearData()
        
        // for testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadHomeData()
        }
    }
}
