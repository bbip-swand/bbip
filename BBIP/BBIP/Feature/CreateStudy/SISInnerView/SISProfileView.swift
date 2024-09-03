//
//  SISProfileView.swift
//  BBIP
//
//  Created by 이건우 on 8/31/24.
//

import SwiftUI

struct SISProfileView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SetStudyImageView(viewModel: viewModel)
                .padding(.top, 181)
                .padding(.bottom, 40)
            
            SetStudyNameView(viewModel: viewModel)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(image: $viewModel.selectedImage)
                .ignoresSafeArea(edges: .bottom)
        }
        .padding(.horizontal, 20)
        .hideKeyboard()
    }
}

fileprivate struct SetStudyImageView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    private let imageSize: CGFloat = 160
    
    var body: some View {
        Button {
            viewModel.showImagePicker = true
        } label: {
            ZStack(alignment: .bottomTrailing) {
                if let selectedImage = viewModel.selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(Circle())
                        .radiusBorder(
                            cornerRadius: imageSize / 2,
                            color: .gray4,
                            lineWidth: 2
                        )
                } else {
                    Image("study_profile_default")
                        .resizable()
                        .frame(width: 160, height: 160)
                }
                Image("study_profile_edit")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 16.5)
            }
        }
    }
}

fileprivate struct SetStudyNameView: View {
    @ObservedObject var viewModel: CreateStudyViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("15자 이내로 작성해주세요", text: $viewModel.studyName)
                .font(.bbip(.body1_m16))
                .onChange(of: viewModel.studyName) { _, newValue in
                    viewModel.hasStartedEditing = true
                    validateNameAndUpdateNextButton(newValue)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .introspect(.textField, on: .iOS(.v17)) { textField in
                    textField.autocorrectionType = .no
                    textField.autocapitalizationType = .none
                    textField.spellCheckingType = .no
                }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(viewModel.hasStartedEditing ? Color.red : Color.gray3)
            
            HStack {
                if viewModel.hasStartedEditing && !viewModel.isNameValid {
                    WarningLabel(errorText: "2~15자 이내로 한글로 작성해주세요.")
                }
            }
            .foregroundColor(.red)
            .frame(height: 20)
            .padding(.top, 8)
        }
    }
    
    private func validateNameAndUpdateNextButton(_ name: String) {
        // 한글, 띄어쓰기 포함, 2자 이상 15자 이하
        let regex = "^[가-힣\\s]{2,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        viewModel.isNameValid = predicate.evaluate(with: name)
        viewModel.canGoNext[2] = predicate.evaluate(with: name)
    }
}
