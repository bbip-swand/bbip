//
//  SubmitAttendanceCodeUseCaseProtocol.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Combine

protocol SubmitAttendanceCodeUseCaseProtocol {
    func execute(studyId: String, code: Int) -> AnyPublisher<Bool, AttendanceError>
}

final class SubmitAttendanceCodeUseCase: SubmitAttendanceCodeUseCaseProtocol {
    private let repository: AttendanceRepository
    
    init(repository: AttendanceRepository) {
        self.repository = repository
    }
    
    /// 출석 인증 코드 입력
    func execute(studyId: String, code: Int) -> AnyPublisher<Bool, AttendanceError> {
        repository.submitAttendanceCode(studyId: studyId, code: code)
    }
}
