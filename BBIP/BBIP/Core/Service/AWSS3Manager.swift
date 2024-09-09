//
//  AWSS3Manager.swift
//  BBIP
//
//  Created by 이건우 on 9/4/24.
//

import Combine
import Foundation
import UIKit
import Moya

final class AWSS3Manager {
    static let shared = AWSS3Manager()
    private let provider = MoyaProvider<AWSS3API>()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}

    func upload(image: UIImage) -> AnyPublisher<String, Error> {
        let uuid = UUID().uuidString
        
        // Presigned URL 요청 후, 이미지 업로드 및 최종 URL 반환
        return requestPresignedURL(with: uuid)
            .flatMap { [weak self] urlString -> AnyPublisher<String, Error> in
                guard let self = self, let imageData = image.jpegData(compressionQuality: 1) else {
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
                print("Presigned URL: \(urlString)") // Presigned URL 확인
                // 이미지 업로드 후 final URL 반환
                return self.uploadImageToBinary(imageData: imageData, urlString: urlString)
                    .map { _ in
                        let finalURL = "https://bbip-s3-bucket.s3.amazonaws.com/images/\(uuid)"
                        return finalURL
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    // Presigned URL 요청
    func requestPresignedURL(with uuid: String) -> AnyPublisher<String, Error> {
        return provider.requestPublisher(.requestPresignedUrl(fileName: uuid))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print(response.statusCode)
                    throw URLError(.badServerResponse)
                }

                // 응답 데이터 확인
                guard let urlString = String(data: response.data, encoding: .utf8), !urlString.isEmpty else {
                    print("응답 데이터가 올바르지 않습니다:", response.data)
                    throw URLError(.cannotParseResponse)
                }
                return urlString
            }
            .eraseToAnyPublisher()
    }

    // presigned URL에 이미지 업로드
    func uploadImageToBinary(imageData: Data, urlString: String) -> AnyPublisher<Void, Error> {
        provider.requestPublisher(.upload(imageData: imageData, url: urlString))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print(response.statusCode)
                    throw URLError(.badServerResponse)
                }
                return ()
            }
            .eraseToAnyPublisher()
    }
}
