//
//  ArchiveViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation
import Combine

final class ArchiveViewModel: ObservableObject {
    @Published var archivedFileInfo: [ArchivedFileInfoVO]?
    @Published var isLoading: Bool = false
    
    private let getArchivedFileInfoUseCase: GetArchivedFileInfoUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getArchivedFileInfoUseCase: GetArchivedFileInfoUseCaseProtocol
    ) {
        self.getArchivedFileInfoUseCase = getArchivedFileInfoUseCase
    }
    
    func getArchivedFile(studyId: String) {
        getArchivedFileInfoUseCase.execute(studyId: studyId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("load failed ArchivedFile: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.archivedFileInfo = response
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
