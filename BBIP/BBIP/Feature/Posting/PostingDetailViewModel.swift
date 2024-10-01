//
//  PostingDetailViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation
import Combine

final class PostingDetailViewModel: ObservableObject {
    @Published var postDetailData: PostDetailVO?
    @Published var commentText: String = ""
    
    private let getPostDetailUseCase: GetPostDetailUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(getPostDetailUseCase: GetPostDetailUseCaseProtocol) {
        self.getPostDetailUseCase = getPostDetailUseCase
    }
    
    func getPostDetail(postingId: String) {
        getPostDetailUseCase.excute(postingId: postingId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("load failed PostDetail: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.postDetailData = response
                print(postDetailData)
            }
            .store(in: &cancellables)
    }
}
