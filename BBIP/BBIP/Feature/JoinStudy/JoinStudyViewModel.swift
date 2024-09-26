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

    func joinStudy(studyId: String, handleError: @escaping () -> Void) {
        joinStudyUseCase.excute(studyId: studyId)
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
                } else {
                    print("이미 참여된 스터디입니다")
                    handleError()
                }
            }
            .store(in: &cancellables)
    }
}
