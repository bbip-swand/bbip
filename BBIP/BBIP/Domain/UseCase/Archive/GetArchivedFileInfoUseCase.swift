//
//  GetArchivedFileUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation
import Combine

protocol GetArchivedFileInfoUseCaseProtocol {
    func excute(studyId: String) -> AnyPublisher<[ArchivedFileInfoVO], Error>
}

final class GetArchivedFileInfoUseCase: GetArchivedFileInfoUseCaseProtocol {
    private let repository: ArchiveRepository
    
    init(repository: ArchiveRepository) {
        self.repository = repository
    }
    
    func excute(studyId: String) -> AnyPublisher<[ArchivedFileInfoVO], Error> {
        repository.getArchivedFile(studyId: studyId)
            .eraseToAnyPublisher()
    }
}
