//
//  StudyHomeViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/27/24.
//

import Foundation
import Combine

class StudyHomeViewModel: ObservableObject {
    // Datas
    @Published var fullStudyInfo: FullStudyInfoVO? = .mock()
    
    // UseCases
    private let getFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol
    ) {
        self.getFullStudyInfoUseCase = getFullStudyInfoUseCase
    }
    
    func requestFullStudyInfo(studyId: String) {
        getFullStudyInfoUseCase.excute(studyId: studyId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.fullStudyInfo = response
            }
            .store(in: &cancellables)
    }
}
