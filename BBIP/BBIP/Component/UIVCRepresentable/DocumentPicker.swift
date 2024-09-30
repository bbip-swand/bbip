//
//  DocumentPicker.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
    var completion: (Data?, String?) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completion)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [
            .pdf,
            .jpeg,
            .png,
            .plainText,
            .presentation,
            .avi,
            .movie,
            .fileURL,
            .zip,
            .html,
            .image,
            .video,
            .json
        ])
        documentPicker.delegate = context.coordinator
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var completion: (Data?, String?) -> Void

        init(completion: @escaping (Data?, String?) -> Void) {
            self.completion = completion
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else {
                completion(nil, nil)
                return
            }

            // 보안 스코프 권한 요청 시작
            let accessGranted = url.startAccessingSecurityScopedResource()
            defer { url.stopAccessingSecurityScopedResource() }  // 접근이 끝나면 중지

            guard accessGranted else {
                print("파일 접근 권한이 거부되었습니다.")
                completion(nil, nil)
                return
            }

            do {
                // 파일을 임시 디렉토리로 복사
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(url.lastPathComponent)

                if FileManager.default.fileExists(atPath: tempURL.path) {
                    try FileManager.default.removeItem(at: tempURL)  // 이미 파일이 있다면 삭제
                }

                try FileManager.default.copyItem(at: url, to: tempURL)

                // 이제 임시 위치에서 파일 데이터를 읽어 올 수 있습니다
                let fileData = try Data(contentsOf: tempURL)
                completion(fileData, url.lastPathComponent)
            } catch {
                print("파일 복사 중 오류 발생: \(error)")
                completion(nil, nil)
            }
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            completion(nil, nil)
        }
    }
}
