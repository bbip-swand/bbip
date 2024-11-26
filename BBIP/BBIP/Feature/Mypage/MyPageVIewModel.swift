//
//  MyPageViewModel.swift
//  BBIP
//
//  Created by 이건우 on 11/11/24.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

final class MyPageViewModel : ObservableObject {
    @Published var isLoading: Bool = false
    @Published var profileData: UserInfoVO? = nil
    
    // Parsed Data
    @Published var parsedArea: String = ""
    @Published var parsedInterests: [String] = []
    @Published var parsedOccupation: String = ""
    @Published var finishedStudyData: [StudyInfoVO]?
    @Published var ongoingStudyCount: Int = 0
    @Published var finishedStudyCount: Int = 0
    @Published var ongoingStudyData: [StudyInfoVO]?
    
    private let getProfileUseCase: GetProfileUseCaseProtocol
    private let getFinishedStudyUseCase : GetFinishedStudyInfoUseCaseProtocol
    private let getOngoingStudyUseCase : GetOngoingStudyInfoUseCaseProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(
        getProfileUseCase : GetProfileUseCaseProtocol,
        getFinishedStudyUseCase : GetFinishedStudyInfoUseCaseProtocol,
        getOngoingStudyUseCase : GetOngoingStudyInfoUseCaseProtocol,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.cancellables = cancellables
        self.getProfileUseCase = getProfileUseCase
        self.getFinishedStudyUseCase = getFinishedStudyUseCase
        self.getOngoingStudyUseCase = getOngoingStudyUseCase
    }
    
    func getProfileInfo() {
        getProfileUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink{completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    error.handleDecodingError()
                    print("fail load profile data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] records in
                guard let self = self else { return }
                self.profileData = records
                self.parseProfileData(records)
            }
            .store(in: &cancellables)
    }
    
    private func parseProfileData(_ profile: UserInfoVO) {
        // selected area
        self.parsedArea = profile.selectedArea.compactMap { $0 }.joined(separator: " ")
        
        // selected interests
        self.parsedInterests = profile.selectedInterestIndex.compactMap { index in
            StudyCategory.from(int: index)?.rawValue
        }
        
        // occupation
        self.parsedOccupation = profile.selectedJobIndex.compactMap { index in
            OccupationCategory.from(int: index)?.rawValue
        }.first ?? "알 수 없음"
    }
    
    func getOngoingStudyInfo() {
        getOngoingStudyUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("failed to load ongoing study: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.ongoingStudyData = response
                self.ongoingStudyCount = response.count
            }
            .store(in: &cancellables)
    }
    
    func getFinishedStudyInfo() {
        getFinishedStudyUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("failed to load finished study: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.finishedStudyData = response
                self.finishedStudyCount = response.count
            }
            .store(in: &cancellables)
    }
}
