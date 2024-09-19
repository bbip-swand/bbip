//
//  AttendanceCertificationViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import Foundation

final class AttendanceCertificationViewModel: ObservableObject {
    // MARK: - Code
    @Published var codeDigits: [String] = ["", "", "", ""]
    @Published var isRight: Bool = true
    @Published var combinedCode: String = ""
    
    func handleTextFieldChange(index: Int, newValue: String) -> Int? {
            if newValue.isEmpty {
                return moveToPreviousField(index: index)
            } else {
                codeDigits[index] = String(newValue.prefix(1))
                updateCombinedCode()
                
                if isComplete() {
                    validateYear() //TODO:  모든 입력이 완료되었을 때 유효성 검사(api 연결해야함) - 현재는 생년검사와 동일한 로직
                }
                return moveToNextField(index: index)
            }
        }
    
    
    func moveToNextField(index: Int) -> Int? {
        return (index < 3) ? index + 1 : nil
    }
    
   
    func moveToPreviousField(index: Int) -> Int? {
        return (index > 0) ? index - 1 : 0
    }
    
    func isComplete() -> Bool {
        return codeDigits.allSatisfy { $0.count == 1 }
    }
    
    //TODO: 여기도 로직 바뀌어야 함
    func validateYear() {
        let yearString = codeDigits.joined()
        if let year = Int(yearString), (1950...Calendar.current.component(.year, from: Date())).contains(year) {
            isRight = true
        } else {
            isRight = false
        }
    }
    
    func updateCombinedCode() {
        combinedCode = codeDigits.joined()
    }
    
    
}
