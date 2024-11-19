//
//  AttendanceCertificationViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import Foundation
import Combine

/// 출결 인증을 위한 VM, 스터디원 & 홈 화면용
final class AttendanceCertificationViewModel: ObservableObject {
    // MARK: - Code
    @Published var codeDigits: [String] = ["", "", "", ""]
    @Published var combinedCode: String = ""
    @Published var isWrongCode: Bool = false
    @Published var showDoneView: Bool = false
    @Published var errorMessage: String = .init()
    
    private let submitAttendanceCodeUseCase: SubmitAttendanceCodeUseCaseProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(submitAttendanceCodeUseCase: SubmitAttendanceCodeUseCaseProtocol) {
        self.submitAttendanceCodeUseCase = submitAttendanceCodeUseCase
    }
    
    func submitCode(studyId: String) {
        guard let code = Int(combinedCode) else { return }
        submitAttendanceCodeUseCase.execute(studyId: studyId, code: code)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    self.isWrongCode = error == .invalidCode
                    self.errorMessage = error.errorMessage
                }
            } receiveValue: { isCorrectCode in
                print(isCorrectCode)
                self.isWrongCode = !isCorrectCode
                self.showDoneView = isCorrectCode
            }
            .store(in: &cancellables)
    }
    
    func isAllEntered() -> Bool {
        return codeDigits.allSatisfy { $0.count == 1 }
    }
}

extension AttendanceCertificationViewModel {
    func handleTextFieldChange(index: Int, newValue: String) -> Int? {
        if newValue.isEmpty {
            return moveToPreviousField(index: index)
        } else {
            codeDigits[index] = String(newValue.prefix(1))
            updateCombinedCode()
            return moveToNextField(index: index)
        }
    }
    
    private func moveToNextField(index: Int) -> Int? {
        return (index < 3) ? index + 1 : nil
    }
    
    private func moveToPreviousField(index: Int) -> Int? {
        return (index > 0) ? index - 1 : 0
    }
    
    private func updateCombinedCode() {
        combinedCode = codeDigits.joined()
    }
}
