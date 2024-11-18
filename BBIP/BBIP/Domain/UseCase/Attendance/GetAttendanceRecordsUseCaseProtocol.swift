//
//  GetAttendanceRecordsUseCaseProtocol.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Combine

protocol GetAttendanceRecordsUseCaseProtocol {
    func execute(studyId: String) -> AnyPublisher<[AttendanceRecordVO], AttendanceError>
}

final class GetAttendanceRecordsUseCase: GetAttendanceRecordsUseCaseProtocol {
    private let repository: AttnedanceRepository
    
    init(repository: AttnedanceRepository) {
        self.repository = repository
    }
    
    /// 스터디원들의 출결 현황 조회
    func execute(studyId: String) -> AnyPublisher<[AttendanceRecordVO], AttendanceError> {
        repository.getAttendanceRecords(studyId: studyId)
    }
}
