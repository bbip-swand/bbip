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
    @Published var studyBulletnData: RecentPostVO?
    @Published var attendaceStatus: AttendanceStatusVO?
    @Published var isAttendanceStart: Bool = false
    
    // UseCases
    private let getFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol
    private let getStudyPostingUseCase: GetStudyPostingUseCaseProtocol
    private let getAttendanceStatusUseCase: GetAttendanceStatusUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol,
        getStudyPostingUseCase: GetStudyPostingUseCaseProtocol,
        getAttendanceStatusUseCase: GetAttendanceStatusUseCaseProtocol
    ) {
        self.getFullStudyInfoUseCase = getFullStudyInfoUseCase
        self.getStudyPostingUseCase = getStudyPostingUseCase
        self.getAttendanceStatusUseCase = getAttendanceStatusUseCase
    }
    
    func reloadFullStudyInfo(studyId: String) {
        fullStudyInfo = nil
        studyBulletnData = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.requestFullStudyInfo(studyId: studyId)
            self.getStudyPosting(studyId: studyId)
        }
    }
    
    func requestFullStudyInfo(studyId: String) {
        isFullInfoLoaded = true
        getFullStudyInfoUseCase.execute(studyId: studyId)
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
    
    func getStudyPosting(studyId: String) {
        getStudyPostingUseCase.execute(studyId: studyId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.studyBulletnData = response
            }
            .store(in: &cancellables)
    }
    
    func getAttendanceStatus() {
        getAttendanceStatusUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.errorMessage)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.attendaceStatus = response
                self.isAttendanceStart = true
            }
            .store(in: &cancellables)
    }
}
