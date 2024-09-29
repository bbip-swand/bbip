//
//  StudyHomeViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/27/24.
//

import Foundation
import Combine

final class StudyHomeViewModel: ObservableObject {
    @Published var isFullInfoLoaded: Bool = false
    @Published var fullStudyInfo: FullStudyInfoVO?
    
    // UseCases
    private let getFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol
    ) {
        self.getFullStudyInfoUseCase = getFullStudyInfoUseCase
    }
    
    func requestFullStudyInfo(studyId: String) {
        isFullInfoLoaded = true
        getFullStudyInfoUseCase.excute(studyId: studyId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.fullStudyInfo = response
                self.isFullInfoLoaded = false
            }
            .store(in: &cancellables)
    }
    
    func reloadFullStudyInfo(studyId: String) {
        fullStudyInfo = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.requestFullStudyInfo(studyId: studyId)
        }
    }
}
