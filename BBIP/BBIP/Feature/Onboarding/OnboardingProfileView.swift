//
//  OnboardingProfileView.swift
//  BBIP
//
//  Created by 조예린 on 8/16/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct OnboardingProfileView: View {
    @State private var userName: String = ""
    @State private var isNameValid: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var hasStartedEditing: Bool = false

    var body: some View {
        VStack(alignment:.leading) {
            // 상단문구
            OnboardingHeaderView()

            Spacer().frame(height:49)

            OnboardingProfileImageAndNameView(
                selectedImage: $selectedImage,
                showImagePicker: $showImagePicker,
                userName: $userName,
                isNameValid: $isNameValid,
                hasStartedEditing: $hasStartedEditing
            )

            Spacer().frame(height:216)

        }
        .navigationBarBackButtonHidden(false)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        
        
        MainButton(
            text: "다음",
            enable: isNameValid
        ) {
            // 다음 버튼 동작 수정필요
        }
        .padding(.bottom, 39)
        .padding(.horizontal)
    }
}

// 상단 안내 문구 뷰
private struct OnboardingHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("프로필을 꾸며보세요")
                .font(.bbip(family:.Regular, size: 24))
                .fontWeight(.bold)
                .padding(.top, 120) // 추후 헤더 간격 조정필요(Tabview영역이 120, 프로그래스바부터 40)

            Text("스터디원들에게 보일 프로필을 만들어주세요")
                .font(.bbip(family: .Regular, size:16 ))
                .foregroundColor(.gray)
                .padding(.top, 10)
        }
        .padding(.leading)
    }
}

// 프로필 이미지 및 이름 입력 뷰
private struct OnboardingProfileImageAndNameView: View {
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    @Binding var userName: String
    @Binding var isNameValid: Bool
    @Binding var hasStartedEditing: Bool // Track if editing has started

    var body: some View {
        VStack {
            ZStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                } else {
                    Image("profile_default")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                    
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black).frame(width: 30, height: 30))
                    }
                }
            }
            .padding(.bottom, 40) // 간격 조정

            VStack(spacing: 0) {
                TextField("실명을 입력해주세요", text: $userName) 
                    .onChange(of: userName) { newValue in
                    hasStartedEditing = true
                    validateName(newValue)
                    
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(hasStartedEditing ? Color.red : Color.gray3),
                    alignment: .bottom
                )
                

                if hasStartedEditing && !isNameValid {
                    HStack {
                        
                        Text("실명을 작성해주세요. 숫자, 특수문자는 사용할 수 없습니다.")
                            .foregroundColor(.red)
                            .font(.bbip(family:.Medium, size:12))
                            .multilineTextAlignment(.center)
                       

                        Button(action: {
                            userName = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                
                    .padding(.top, 4)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top)
    }

    private func validateName(_ name: String) {
        let regex = "^[가-힣a-zA-Z]{2,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        isNameValid = predicate.evaluate(with: name)
        
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

// Preview
#Preview {
    OnboardingProfileView()
}
