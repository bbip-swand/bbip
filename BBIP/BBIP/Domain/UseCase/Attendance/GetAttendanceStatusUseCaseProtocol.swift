//
//  GetAttendanceStatusUseCaseProtocol.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Combine

protocol GetAttendanceStatusUseCaseProtocol {
    func execute() -> AnyPublisher<AttendanceStatusVO, AttendanceError>
}

final class GetAttendanceStatusUseCase: GetAttendanceStatusUseCaseProtocol {
    private let repository: AttendanceRepository
    
    init(repository: AttendanceRepository) {
        self.repository = repository
    }
    
    /// 현재 진행중인 출결인증이 있는지 여부 확인
    func execute() -> AnyPublisher<AttendanceStatusVO, AttendanceError> {
        repository.getAttendanceStatus()
    }
}
