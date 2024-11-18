//
//  CreateAttendanceCodeUseCaseProtocol.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Combine

protocol CreateAttendanceCodeUseCaseProtocol {
    func execute(studyId: String, session: Int) -> AnyPublisher<Int, AttendanceError>
}

final class CreateAttendanceCodeUseCase: CreateAttendanceCodeUseCaseProtocol {
    private let repository: AttnedanceRepository
    
    init(repository: AttnedanceRepository) {
        self.repository = repository
    }
    
    /// 출결 코드 생성 (스터디장만 가능)
    func execute(studyId: String, session: Int) -> AnyPublisher<Int, AttendanceError> {
        repository.createAttendanceCode(studyId: studyId, session: session)
    }
}
