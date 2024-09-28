//
//  CreateCodeViewModel.swift
//  BBIP
//
//  Created by 조예린 on 9/28/24.
//

import Foundation
import Combine
import CombineMoya

//TODO: studyHome에서 createcodeviewmodel로 studyid옮기기
class CreateCodeViewModel: ObservableObject{
    
    @Published var postCode: Int = 1234 // 코드보낼때
    @Published var getCode: String = ""
    private var createCodeUseCase: CreateCodeUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(createCodeUseCase: CreateCodeUseCaseProtocol) {
        self.createCodeUseCase = createCodeUseCase
    }
    
    func createCode() {
        // TODO: studyhome에서 이어붙이기
        let attendVO = AttendVO(studyId: "f1937080-0938-438b-aef5-2ae581bd8f42", session: 1, code: postCode)
        
        createCodeUseCase.execute(attendVO: attendVO)
            .map { $0.code } // CreateCodeResponseDTO에서 code만 추출
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error occurred: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] code in
                self?.getCode = String(code)// 받은 코드를 저장
            })
            .store(in: &cancellables)
        
        print(getCode)
    }
}
