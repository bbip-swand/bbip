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
    @Published var stringCode: String = ""
    @Published var combinedCode:Int = 0
    
    func handleTextFieldChange(index: Int, newValue: String) -> Int? {
            if newValue.isEmpty {
                return moveToPreviousField(index: index)
            } else {
                codeDigits[index] = String(newValue.prefix(1))
                updateCombinedCode()
                
                if isComplete() {
                    
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
    
    func updateCombinedCode() {
        stringCode = codeDigits.joined()
        combinedCode = Int(stringCode) ?? 0
        print(combinedCode)
    }
    
    
}
