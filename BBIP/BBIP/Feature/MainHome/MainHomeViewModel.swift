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
    @Published var currentWeekStudyData = CurrentWeekStudyInfoVO.generateMock()
    @Published var commingScheduleData = CommingScheduleVO.generateMock()
    
    // real data
    @Published var homeBulletnData: CurrentWeekPostVO?
    
    // 게시판 글 불러오기
    private let getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.getCurrentWeekPostUseCase = getCurrentWeekPostUseCase
        self.cancellables = cancellables
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
                print(response)
                self.homeBulletnData = response
            }
            .store(in: &cancellables)
    }
}
