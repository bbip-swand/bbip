//
//  JoinStudyViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/26/24.
//

import Foundation
import SwiftUI
import Combine

class JoinStudyViewModel: ObservableObject {
    @EnvironmentObject var appState: AppStateManager
    private let joinStudyUseCase: JoinStudyUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(joinStudyUseCase: JoinStudyUseCaseProtocol) {
        self.joinStudyUseCase = joinStudyUseCase
    }

    /// completion closure type
    func joinStudy(studyId: String, completion: @escaping (Bool) -> Void) {
        joinStudyUseCase.execute(studyId: studyId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { isSuccess in
                if isSuccess {
                    print("스터디 참여 성공")
                    completion(true)
                } else {
                    print("이미 참여된 스터디입니다")
                    completion(false)
                }
            }
            .store(in: &cancellables)
    }
    
    /// publisher type
    func joinStudy(studyId: String) -> AnyPublisher<Bool, Never> {
        joinStudyUseCase.execute(studyId: studyId)
            .catch { _ in Just(false) }
            .eraseToAnyPublisher()
    }
}
