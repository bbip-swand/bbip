//
//  AttendanceRecordsViewModel.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Foundation
import Combine

final class AttendanceRecordsViewModel: ObservableObject {
    
    @Published var records: [AttendanceRecordVO]?
    
    private let getAttendanceRecordsUseCase: GetAttendanceRecordsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(getAttendanceRecordsUseCase: GetAttendanceRecordsUseCaseProtocol) {
        self.getAttendanceRecordsUseCase = getAttendanceRecordsUseCase
    }
    
    func getAttendanceRecords(studyId: String) {
        getAttendanceRecordsUseCase.execute(studyId: studyId)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.records = response
            }
            .store(in: &cancellables)
    }
}
