//
//  AWSS3Manager.swift
//  BBIP
//
//  Created by 이건우 on 9/4/24.
//

import Foundation
import AWSS3

final class AWSS3Manager {
    typealias ProgressBlock = (_ progress: Double) -> Void
    typealias CompletionBlock = (_ url: URL?, _ error: Error?) -> Void
    
    static let shared = AWSS3Manager()
    
    private init() {}
    
    /// AWS S3에 데이터를 업로드합니다.
    /// - Parameters:
    ///   - contentType: 파일의 MIME 타입(e.g., "image/jpeg").
    ///   - data: 업로드할 데이터.
    ///   - progress: 업로드 진행 상황을 나타내는 블록.
    ///   - completion: 업로드 완료 시 호출되는 블록. 성공 시 URL, 실패 시 Error를 반환합니다.
    func upload(
        contentType type: String,
        data: Data,
        progress: ProgressBlock? = nil,
        completion: @escaping CompletionBlock
    ) {
        guard let accessKey = (Bundle.main.object(forInfoDictionaryKey: "AWS_ACCESS_KEY") as? String)?.replacingOccurrences(of: "\"", with: ""),
              let secretKey = (Bundle.main.object(forInfoDictionaryKey: "AWS_SECRET_KEY") as? String)?.replacingOccurrences(of: "\"", with: ""),
              let sessionToken = (Bundle.main.object(forInfoDictionaryKey: "AWS_SESSION_TOKEN") as? String)?.replacingOccurrences(of: "\"", with: "") else {
            fatalError("AWS Keys are not set properly in Config.xcconfig")
        }
        
        let credentialProvider = AWSBasicSessionCredentialsProvider(
            accessKey: accessKey,
            secretKey: secretKey,
            sessionToken: sessionToken
        )
        
        // AWS 서비스 구성
        let config = AWSServiceConfiguration(
            region: .APNortheast2, // 서울 리전
            credentialsProvider: credentialProvider
        )
        
        AWSServiceManager.default().defaultServiceConfiguration = config
        AWSS3TransferUtility.register(with: config!, forKey: "S3TransferUtility")
        
        // 업로드 표현식 설정 (진행 상황 블록)
        let awsUploadExp = AWSS3TransferUtilityUploadExpression()
        awsUploadExp.progressBlock = { task, progressData in
            progress?(progressData.fractionCompleted)
        }
        
        // Transfer Utility 인스턴스 생성
        guard let transferUtility = AWSS3TransferUtility.s3TransferUtility(forKey: "S3TransferUtility") else {
            completion(nil, NSError(domain: "AWSS3Manager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Transfer Utility를 초기화할 수 없습니다."]))
            return
        }
        
        // 업로드 완료 핸들러
        let completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock = { task, error in
            if let error = error {
                completion(nil, error)
            } else {
                // 업로드된 파일의 S3 URL 생성
                // let bucket = task.bucket
                // let key = task.key
                // let url = URL(string: "https://\(bucket).s3.amazonaws.com/\(key)")
                guard let responseURL = task.response?.url else { return }
                let url = URL(string: responseURL.absoluteString.components(separatedBy: "?")[0])
                completion(url, nil)
            }
        }
        
        let uuid = UUID().uuidString
        
        // 데이터 업로드 시작
        transferUtility.uploadData(
            data,
            bucket: "bbip-s3-bucket", // 버킷 이름
            key: "images/\(uuid)",
            contentType: type,
            expression: awsUploadExp,
            completionHandler: completionHandler
        ).continueWith { task in
            if let error = task.error {
                completion(nil, error)
            }
            return nil
        }
    }
}
