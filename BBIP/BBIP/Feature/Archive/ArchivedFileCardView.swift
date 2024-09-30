//
//  ArchivedFileCardView.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import SwiftUI

struct ArchivedFileCardView: View {
    private let fileInfo: ArchivedFileInfoVO
    
    init(fileInfo: ArchivedFileInfoVO) {
        self.fileInfo = fileInfo
    }
    
    func openDownloadLink(_ urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url) { success in
            if success {
                print("Successfully opened URL")
            } else {
                print("Failed to open URL")
            }
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(fileInfo.fileName)
                    .font(.bbip(.body1_sb16))
                    .foregroundStyle(.gray8)
                    .frame(height: 20)
                
                HStack(spacing: 16) {
                    Text(fileInfo.fileSize)
                    Text(fileInfo.createdAt)
                }
                .font(.bbip(.caption3_r12))
                .foregroundStyle(.gray5)
            }
            
            Spacer()
                .frame(width: 56)
            
            Button {
                openDownloadLink(fileInfo.fileUrl)
            } label: {
                Image("download")
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 13)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .bbipShadow1()
        )
    }
}
