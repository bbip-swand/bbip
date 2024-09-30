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
    private let studyId: String
    
    init(studyId: String) {
        self.studyId = studyId
    }
    
    var body: some View {
        VStack {
            Spacer()
        }
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
                    
                    print("upload start")
                    AWSS3Manager.shared.upload(file: fileData, fileName: fileName, fileKey: fileKey, studyId: studyId)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }, receiveValue: { success in
                            if success {
                                print("upload success!")
                            }
                        })
                        .store(in: &cancellables)
                }
            }
        }
    }
}

#Preview {
    ArchiveView(studyId: "")
}
