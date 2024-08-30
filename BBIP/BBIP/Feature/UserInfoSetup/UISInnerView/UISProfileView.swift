//
//  UISProfileView.swift
//  BBIP
//
//  Created by 조예린 on 8/16/24.
//

import SwiftUI
import PhotosUI
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
        .hideKeyboard()
    }
}

private struct SetProfileImageView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        Button {
            viewModel.showImagePicker = true
        } label: {
            ZStack(alignment: .bottomTrailing) {
                if let selectedImage = viewModel.selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
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

private struct SetNicknameView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("실명을 입력해주세요", text: $viewModel.userName)
                .font(.bbip(.body1_m16))
                .onChange(of: viewModel.userName) { _, newValue in
                    viewModel.hasStartedEditing = true
                    validateName(newValue)
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
                    WarningLabel(errorText: "실명을 작성해주세요. 숫자, 특수문자는 사용할 수 없습니다.")
                }
            }
            .foregroundColor(.red)
            .frame(height: 20)
            .padding(.top, 4)
        }
    }
    
    private func validateName(_ name: String) {
        let regex = "^[가-힣]{2,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        viewModel.isNameValid = predicate.evaluate(with: name)
        viewModel.canGoNext[2] = predicate.evaluate(with: name)
    }
}

// ImagePicker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}
