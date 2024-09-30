//
//  ArchiveView.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import SwiftUI
import Combine

struct ArchiveView: View {
    @StateObject var viewModel: ArchiveViewModel = DIContainer.shared.makeArchiveViewModel()
    @State private var isDocumentPickerPresented: Bool = false
    @State private var cancellables = Set<AnyCancellable>()
    
    @State private var isUploading: Bool = false
    private let studyId: String
    
    init(studyId: String) {
        self.studyId = studyId
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if let fileInfo = viewModel.archivedFileInfo {
                    if fileInfo.isEmpty {
                        Spacer()
                        Image("archive_placeholder")
                    } else {
                        ForEach(0..<fileInfo.count, id: \.self) { index in
                            ArchivedFileCardView(fileInfo: fileInfo[index])
                        }
                    }
                } else {
                    ForEach(0..<3, id: \.self) { index in
                        ArchivedFileCardView(fileInfo: .placeholderMock())
                            .redacted(reason: .placeholder)
                            .disabled(true)
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.archivedFileInfo)
            .padding(.top, 22)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .containerRelativeFrame([.horizontal])
        .background(.gray1)
        .navigationTitle("아카이브")
        .navigationBarTitleDisplayMode(.inline)
        .backButtonStyle()
        .onAppear {
            viewModel.getArchivedFile(studyId: studyId)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isDocumentPickerPresented = true
                } label: {
                    Image("plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 14)
                }
            }
        }
        .sheet(isPresented: $isDocumentPickerPresented) {
            DocumentPicker { fileData, fileName in
                if let fileData = fileData, let fileName = fileName {
                    let fileKey = UUID().uuidString
                    let studyId = studyId
                    
                    withAnimation { isUploading = true }
                    AWSS3Manager.shared.upload(file: fileData, fileName: fileName, fileKey: fileKey, studyId: studyId)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                print(error.localizedDescription)
                                isUploading = false
                            }
                        }, receiveValue: { success in
                            if success {
                                viewModel.getArchivedFile(studyId: studyId)
                                withAnimation { isUploading = false }
                            }
                        })
                        .store(in: &cancellables)
                }
            }
        }
        .loadingOverlay(isLoading: $isUploading, withBackground: false)
    }
}

#Preview {
    ArchiveView(studyId: "")
}
