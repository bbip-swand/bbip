//
//  UISProfileView.swift
//  BBIP
//
//  Created by 조예린 on 8/16/24.
//

import SwiftUI
import SwiftUIIntrospect

struct UISProfileView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SetProfileImageView(viewModel: viewModel)
                .padding(.top, 181)
                .padding(.bottom, 40)
            
            SetNicknameView(viewModel: viewModel)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(image: $viewModel.selectedImage)
                .ignoresSafeArea(edges: .bottom)
        }
        .padding(.horizontal, 20)
        .keyboardHideable()
    }
}

fileprivate struct SetProfileImageView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
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
                    Image("profile_default")
                        .resizable()
                        .frame(width: 160, height: 160)
                }
                Image("profile_edit")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 16.5)
            }
        }
    }
}

fileprivate struct SetNicknameView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("실명을 입력해주세요", text: $viewModel.userName)
                .focused($isFocused)
                .font(.bbip(.body1_m16))
                .onChange(of: viewModel.userName) { _, newValue in
                    viewModel.hasStartedEditing = true
                    validateName(newValue)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .introspect(.textField, on: .iOS(.v17, .v18)) { textField in
                    textField.autocorrectionType = .no
                    textField.autocapitalizationType = .none
                    textField.spellCheckingType = .no
                }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(!viewModel.userName.isEmpty || isFocused ? Color.red : Color.gray3)
            
            HStack {
                if !viewModel.userName.isEmpty && viewModel.hasStartedEditing && !viewModel.isNameValid {
                    WarningLabel(errorText: "실명을 작성해주세요. 숫자, 특수문자는 사용할 수 없습니다.")
                }
            }
            .foregroundColor(.red)
            .frame(height: 20)
            .padding(.top, 8)
        }
    }
    
    private func validateName(_ name: String) {
        let regex = "^[가-힣]{2,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        viewModel.isNameValid = predicate.evaluate(with: name)
        viewModel.canGoNext[2] = predicate.evaluate(with: name)
    }
}
