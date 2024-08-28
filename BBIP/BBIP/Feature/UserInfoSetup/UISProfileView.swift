//
//  UISProfileView.swift
//  BBIP
//
//  Created by 조예린 on 8/16/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct UISProfileView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            UISProfileImageAndNameView(viewModel: viewModel)
                .padding(.top, 181)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(image: $viewModel.selectedImage)
        }
    }
}

private struct UISProfileImageAndNameView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    var body: some View {
        VStack {
            ZStack {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                } else {
                    Button {
                        viewModel.showImagePicker = true
                    } label: {
                        ZStack {
                            Image("profile_default")
                                .resizable()
                                .frame(width: 160, height: 160)
                                .clipShape(Circle())
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: 30, height: 30)
                                )
                        }
                    }
                }
            }
            .padding(.bottom, 40)
            
            VStack(spacing: 0) {
                TextField("실명을 입력해주세요", text: $viewModel.userName)
                    .font(.bbip(.body1_m16))
                    .onChange(of: viewModel.userName) { _, newValue in
                        viewModel.hasStartedEditing = true
                        validateName(newValue)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(viewModel.hasStartedEditing ? Color.red : Color.gray3)
                
                HStack(spacing: 7) {
                    if viewModel.hasStartedEditing && !viewModel.isNameValid {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                        
                        Text("실명을 작성해주세요. 숫자, 특수문자는 사용할 수 없습니다.")
                            .font(.bbip(.caption2_m12))
                    }
                }
                .foregroundColor(.red)
                .frame(height: 20)
                .padding(.top, 4)
            }
        }
        .padding(.horizontal, 20)
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
