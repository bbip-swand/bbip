//
//  ArchivedFileCardView.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import SwiftUI
import QuickLook

// TODO: - QuickLookPreview data type 처리 안되는 이슈 해결하기
struct ArchivedFileCardView: View {
    @StateObject private var coordinator = Coordinator()
    
    @State private var isDownloading = false
    @State private var downloadProgress: Float = 0.0
    
    @State private var downloadedFileURL: URL? = nil
    @State private var showFilePreview = false
    @State private var downloadTask: URLSessionDownloadTask?  // Track the download task
    
    private let fileInfo: ArchivedFileInfoVO
    
    init(fileInfo: ArchivedFileInfoVO) {
        self.fileInfo = fileInfo
    }
    
    private func downloadFile(from urlStr: String, with fileName: String) {
        guard let url = URL(string: urlStr) else { return }
        
        isDownloading = true
        
        downloadTask = URLSession.shared.downloadTask(with: url) { localURL, response, error in
            if let localURL = localURL {
                // 파일을 앱의 Documents 디렉토리로 복사
                do {
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let destinationURL = documentsDirectory.appendingPathComponent(fileName)
                    
                    // 기존 파일이 있는 경우 삭제
                    if FileManager.default.fileExists(atPath: destinationURL.path) {
                        try FileManager.default.removeItem(at: destinationURL)
                    }
                    
                    // 파일 이동
                    try FileManager.default.moveItem(at: localURL, to: destinationURL)
                    
                    // 다운로드 완료 시
                    DispatchQueue.main.async {
                        isDownloading = false
                        downloadedFileURL = destinationURL
                        showDocumentPicker(for: destinationURL)

                        print("File downloaded to: \(destinationURL.path)")
                    }
                } catch {
                    print("File error: \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Download error: \(error.localizedDescription)")
            }
        }
        
        // Progress Tracking (진행 상황 추적)
        let _ = downloadTask?.progress.observe(\.fractionCompleted) { progress, _ in
            DispatchQueue.main.async {
                downloadProgress = Float(progress.fractionCompleted)
            }
        }
        downloadTask?.resume()  // 다운로드 시작
    }
    
    private func showDocumentPicker(for url: URL) {
        let documentPicker = UIDocumentPickerViewController(forExporting: [url])
        documentPicker.delegate = coordinator
        documentPicker.modalPresentationStyle = .formSheet
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(fileInfo.fileName)
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.gray8)
                    .frame(height: 20)
                    .frame(maxWidth: UIScreen.main.bounds.width - 156, alignment: .leading)
                
                HStack(spacing: 16) {
                    Text(fileInfo.fileSize)
                    Text(fileInfo.createdAt)
                }
                .font(.bbip(.caption3_r12))
                .foregroundStyle(.gray5)
            }
            
            Spacer()
            
            if isDownloading {
                ProgressView()
                    .frame(width: 20, height: 20)
            }
            
            Button {
                downloadFile(from: fileInfo.fileUrl, with: fileInfo.fileName)
            } label: {
                Image("download")
            }
            .disabled(isDownloading)
            
            /*
             if coordinator.downloadSuccess {
                 Button {
                     showFilePreview = true
                 } label: {
                     Image("file")
                         .renderingMode(.template)
                         .foregroundStyle(.gray8)
                 }
             }
             */
        }
        .padding(.top, 16)
        .padding(.bottom, 13)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .bbipShadow1()
        )
        .onDisappear {
            downloadTask?.cancel()
            isDownloading = false
        }
        //        .sheet(isPresented: $showFilePreview) {
        //            QuickLookPreview(url: downloadedFileURL!)
        //        }
    }
}

class Coordinator: NSObject, UIDocumentPickerDelegate, ObservableObject {
    @Published var downloadSuccess = false
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("File saved successfully.")
        withAnimation { downloadSuccess = true }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Handle cancellation if needed
        print("User cancelled document picker.")
    }
}
