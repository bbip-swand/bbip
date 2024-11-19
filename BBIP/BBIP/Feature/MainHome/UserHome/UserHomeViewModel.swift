//
//  MainHomeViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import Foundation
import Combine

final class UserHomeViewModel: ObservableObject {
    
    // mock data for test
    @Published var commingScheduleData = CommingScheduleVO.generateMock()
    
    @Published var homeBulletnData: RecentPostVO?
    @Published var currentWeekStudyData: [CurrentWeekStudyInfoVO]?
    @Published var ongoingStudyData: [StudyInfoVO]?
    @Published var pendingStudyData: PendingStudyVO?
    @Published var attendanceStatus: AttendanceStatusVO?
    
    // Attendance
    @Published var isAttendanceStarted: Bool = false
    @Published var attendanceRemaningTime: Int?
    
    // UseCases
    private let getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol            // 게시글
    private let getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol  // 이번 주 스터디
    private let getOngoingStudyInfoUseCase: GetOngoingStudyInfoUseCaseProtocol          // 진행중인 스터디
    private let getPendingStudyUseCase: GetPendingStudyUseCaseProtocol                  // 가장 임박한 스터디
    private let getAttendanceStatusUseCase: GetAttendanceStatusUseCaseProtocol          // 출석 인증 유무 확인
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol,
        getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol,
        getOngoingStudyInfoUseCase: GetOngoingStudyInfoUseCaseProtocol,
        getPendingStudyUseCase: GetPendingStudyUseCaseProtocol,
        getAttendanceStatusUseCase: GetAttendanceStatusUseCaseProtocol,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.getCurrentWeekPostUseCase = getCurrentWeekPostUseCase
        self.getCurrentWeekStudyInfoUseCase = getCurrentWeekStudyInfoUseCase
        self.getOngoingStudyInfoUseCase = getOngoingStudyInfoUseCase
        self.getPendingStudyUseCase = getPendingStudyUseCase
        self.getAttendanceStatusUseCase = getAttendanceStatusUseCase
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
        
        getPendingStudyUseCase.excute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("failed load pending study: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.pendingStudyData = response
            }
            .store(in: &cancellables)
        
        getAttendanceStatusUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    if error == .attendanceNotFound {
                        print("진행 중인 출석 없음")
                    } else {
                        print(error.errorMessage)
                    }
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.attendanceStatus = response
                self.isAttendanceStarted = true
                self.attendanceRemaningTime = response.remainingTime
                print(response.remainingTime)
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
